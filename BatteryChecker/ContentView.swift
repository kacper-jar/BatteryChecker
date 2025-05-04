//
//  ContentView.swift
//  BatteryChecker
//
//  Created by Kacper Jarosławski on 04/05/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("prepareThreshold") var prepareThreshold = 40
    @AppStorage("chargeNowThreshold") var chargeNowThreshold = 30
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Battery Notification Settings")
                .font(.headline)
            
            Text("By Kacper Jarosławski")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Stepper("Prepare Charger at: \(prepareThreshold)%", value: $prepareThreshold, in: 10...100)
            
            Stepper("Charger Needed at: \(chargeNowThreshold)%", value: $chargeNowThreshold, in: 5...prepareThreshold - 1)
            
            Text("Settings saved automatically")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Link("GitHub", destination: URL(string: "https://github.com/kacper-jar")!)
                .font(.footnote)
                .foregroundColor(.blue)
        }
        .padding()
        .frame(width: 300)
    }
}

#Preview {
    ContentView()
}
