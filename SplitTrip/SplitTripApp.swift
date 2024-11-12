//
//  SplitTripApp.swift
//  SplitTrip
//
//  Created by AudyDev on 2/11/24.
//

import SwiftUI
import Firebase

@main
struct SplitTripApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
