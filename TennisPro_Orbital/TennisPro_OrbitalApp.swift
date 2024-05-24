//
//  TennisPro_OrbitalApp.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 24/5/24.
//

import SwiftUI
import SwiftData

@main
struct TennisPro_OrbitalApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}