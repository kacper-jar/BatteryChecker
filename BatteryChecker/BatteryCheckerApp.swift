//
//  BatteryCheckerApp.swift
//  BatteryChecker
//
//  Created by Kacper Jarosławski on 04/05/2025.
//

import SwiftUI

@main
struct BatteryCheckerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var popover = NSPopover()
    let monitor = BatteryMonitor()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()
        popover.contentSize = NSSize(width: 300, height: 200)
        popover.contentViewController = NSHostingController(rootView: contentView)

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "battery.100", accessibilityDescription: "Battery Monitor")
            button.action = #selector(togglePopover(_:))
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            popover.performClose(sender)
        } else if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
}
