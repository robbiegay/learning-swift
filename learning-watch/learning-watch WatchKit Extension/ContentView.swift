//
//  ContentView.swift
//  learning-watch WatchKit Extension
//
//  Created by Robbie Gay on 2/19/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import SwiftUI
import MapKit

/*
 ~~alerts and action sheets~~
 ~~buttons~~ (Button)
 - dates and timers
 - groups
 - images
 - labels
 - menus
 - movies
 - pickers
 - sliders
 ~~switches~~ (Toggle)
 - tables
 */

struct ContentView: View {
    @State private var showGreeting = false
    @State private var count = 0
    @State private var showingSheet = false
    
    var body: some View {
        ScrollView {
            VStack {
                // Action Sheet and Alerts
                Button(action: {
                    self.showingSheet = true
                }) {
                    Text("Action Sheet")
                }
                .actionSheet(isPresented: $showingSheet) {
                    ActionSheet(title: Text("What do you want to do?"), message: Text("There's only one choice..."), buttons: [
                        .default(Text("Default")),
                        .destructive(Text("Destructive")),
                    ])
                }
//                .alert(isPresented: $showingSheet) {
//                    Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
//                }
                
                
                // Buttons
                Button(action: {
                    self.count += 1
                }) {
                    Text("Add 1")
                }
                Text("Count: \(count)")
                    .font(.caption)
                    .fontWeight(.bold)
                
                // Toggle
                Toggle(isOn: $showGreeting) {
                    Text("Toggle:")
                }
                if showGreeting {
                    Text("Goodbye")
                } else {
                    Text("Hello")
                }
            }
        }
    }
}
