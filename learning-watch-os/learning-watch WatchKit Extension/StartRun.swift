//
//  StartRun.swift
//  learning-watch WatchKit Extension
//
//  Created by Robbie Gay on 2/24/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import SwiftUI
import MapKit

struct StartRun: View {
    @State private var cause = "Weekend Warriors Run"
    
    var body: some View {
        VStack {
            NavigationLink(destination: ActiveRun()) {
                Text("Start")
                .frame(minHeight: 125, maxHeight: .infinity)
            }
            .background(Color(#colorLiteral(red: 0.8467013836, green: 0.4561516047, blue: 0.005911214277, alpha: 1)))
            .clipShape(Circle())
            Text(cause)
        }
    }
}

//    @State private var showGreeting = false
//    @State private var count = 0
//    @State private var showingSheet = false
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                // Action Sheet and Alerts
//                Button(action: {
//                    self.showingSheet = true
//                }) {
//                    Text("Action Sheet")
//                }
//                .actionSheet(isPresented: $showingSheet) {
//                    ActionSheet(title: Text("What do you want to do?"), message: Text("There's only one choice..."), buttons: [
//                        .default(Text("Default")),
//                        .destructive(Text("Destructive")),
//                    ])
//                }
////                .alert(isPresented: $showingSheet) {
////                    Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
////                }
//
//
//                // Buttons
//                Button(action: {
//                    self.count += 1
//                }) {
//                    Text("Add 1")
//                }
//                Text("Count: \(count)")
//                    .font(.caption)
//                    .fontWeight(.bold)
//
//                // Toggle
//                Toggle(isOn: $showGreeting) {
//                    Text("Toggle:")
//                }
//                if showGreeting {
//                    Text("Goodbye")
//                } else {
//                    Text("Hello")
//                }
//            }
//        }
//    }
