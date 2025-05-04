//
//  ContentView.swift
//  BatteryChecker
//
//  Created by Kacper Jarosławski on 04/05/2025.
//

import SwiftUI
import ServiceManagement

struct ContentView: View {
    @AppStorage("prepareThreshold") var prepareThreshold = 40
    @AppStorage("chargeNowThreshold") var chargeNowThreshold = 30
    @AppStorage("launchAtLogin") private var launchAtLogin: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Battery Checker")
                .font(.headline)

            Text("By Kacper Jarosławski")
                .font(.subheadline)
                .foregroundColor(.gray)

            Stepper("Prepare Charger at: \(prepareThreshold)%", value: $prepareThreshold, in: 10...100)

            Stepper("Charger Needed at: \(chargeNowThreshold)%", value: $chargeNowThreshold, in: 5...prepareThreshold - 1)

            Toggle("Start at login", isOn: $launchAtLogin)
                .onChange(of: launchAtLogin) { newValue in
                    setLaunchAtLogin(enabled: newValue)
                }

            Text("Settings saved automatically")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text("If you don't see notifications, check if they are enabled.")
                .font(.footnote)
                .foregroundColor(.gray)

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
            .padding(.top, 10)

            Link("GitHub", destination: URL(string: "https://github.com/kacper-jar/BatteryChecker")!)
                .font(.footnote)
                .foregroundColor(.blue)
        }
        .padding()
        .frame(width: 300)
    }
}

func setLaunchAtLogin(enabled: Bool) {
    do {
        if enabled {
            try SMAppService.mainApp.register()
            print("Autostart enabled")
        } else {
            try SMAppService.mainApp.unregister()
            print("Autostart disabled")
        }
    } catch {
        print("Failed to change launch at login setting: \(error)")
    }
}

#Preview {
    ContentView()
}
