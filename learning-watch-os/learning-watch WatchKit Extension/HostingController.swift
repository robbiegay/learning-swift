//
//  HostingController.swift
//  learning-watch WatchKit Extension
//
//  Created by Robbie Gay on 2/19/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<StartRun> {
    //    override var body: ContentView {
    //        return ContentView()
    //    }
    override var body: StartRun {
        return StartRun()
    }
}
