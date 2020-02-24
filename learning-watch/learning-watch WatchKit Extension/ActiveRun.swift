//
//  ActiveRun.swift
//  learning-watch WatchKit Extension
//
//  Created by Robbie Gay on 2/24/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import SwiftUI
import MapKit
import WatchKit

struct ActiveRun: View {
    @State private var cause = "Weekend Warriors Run"
    
    @State var start = Date()
    @State var now = Date()
    var calendar = Calendar.current
    let timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    
    // Var for sending the view back to start screen
     @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(calendar.dateComponents([.hour], from: start, to: now).hour!.description):\(calendar.dateComponents([.minute], from: start, to: now).minute!.description):\(calendar.dateComponents([.second], from: start, to: now).second!.description).\(calendar.dateComponents([.nanosecond], from: start, to: now).nanosecond?.description ?? "0000")")
                    .onReceive(timer) { (_) in
                        self.now = Date()
                }
                Text("0.71 miles")
                Text("$8.38 earned")
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                }) {
                    Text("Stop Run")
                        .frame(minHeight: 75, maxHeight: .infinity)
                }
                .background(Color(#colorLiteral(red: 0.8467013836, green: 0.4561516047, blue: 0.005911214277, alpha: 1)))
                .clipShape(Circle())
            }
        }
    }
}
