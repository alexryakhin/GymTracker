//
//  GymTrackerApp.swift
//  GymTracker
//
//  Created by Aleksandr Riakhin on 10/1/23.
//

import SwiftUI

@main
struct GymTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
