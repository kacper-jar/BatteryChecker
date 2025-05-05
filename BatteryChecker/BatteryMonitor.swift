//
//  BatteryMonitor.swift
//  BatteryChecker
//
//  Created by Kacper Jarosławski on 04/05/2025.
//

import Foundation
import IOKit.ps
import UserNotifications

class BatteryMonitor: ObservableObject {
    @Published var batteryLevel: Int = 100
    private var timer: Timer?
    
    var prepareThreshold: Int {
        UserDefaults.standard.integer(forKey: "prepareThreshold") == 0 ? 40 : UserDefaults.standard.integer(forKey: "prepareThreshold")
    }

    var chargeNowThreshold: Int {
        UserDefaults.standard.integer(forKey: "chargeNowThreshold") == 0 ? 30 : UserDefaults.standard.integer(forKey: "chargeNowThreshold")
    }
    
    var chargeFlag: Bool = false
    var prepareFlag: Bool = false

    init() {
        startMonitoring()
        requestNotificationPermission()
    }
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.checkBattery()
        }
        checkBattery()
    }
    
    private func checkBattery() {
        guard let snapshot = IOPSCopyPowerSourcesInfo()?.takeRetainedValue(),
              let sources: NSArray = IOPSCopyPowerSourcesList(snapshot)?.takeRetainedValue(),
              let source = sources.firstObject,
              let description = IOPSGetPowerSourceDescription(snapshot, source as CFTypeRef)?.takeUnretainedValue() as? [String: Any],
              let currentCapacity = description[kIOPSCurrentCapacityKey as String] as? Int,
              let maxCapacity = description[kIOPSMaxCapacityKey as String] as? Int else {
            return
        }
        
        let percentage = (currentCapacity * 100) / maxCapacity
        batteryLevel = percentage
        
        if percentage <= chargeNowThreshold {
            if chargeFlag { return }
            
            sendNotification(
                title: "Charger Needed",
                body: "Your Mac is low on battery.\nPlease connect the power adapter. Battery is at \(percentage)%."
            )
            chargeFlag = true
        }
        else if percentage > chargeNowThreshold && percentage <= prepareThreshold {
            if prepareFlag { return }

            sendNotification(
                title: "Prepare to Charge",
                body: "Your Mac will need charging soon.\nStay near a power source. Battery is at \(percentage)%."
            )
            prepareFlag = true
        }
        else {
            chargeFlag = false
            prepareFlag = true
        }
    }
    
    private func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.interruptionLevel = .critical
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }
}
