//
//  lightwatchApp.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

import SwiftUI

@main
struct lightwatch_Watch_AppApp: App {
   /* @StateObject private var healthManager = HealthManager()*/ // Initialize the HealthManager

        var body: some Scene {
            WindowGroup {
                ContentView()
                    /*.environmentObject(healthManager)*/ // Pass the instance to the environment
            }
        }
    }
