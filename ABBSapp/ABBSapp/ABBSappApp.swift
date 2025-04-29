//
//  ABBSappApp.swift
//  ABBSapp
//
//  Created by Cecilia on 4/24/25.
//

import SwiftUI
import SwiftData

@main
struct ABBSappApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: UserProfile.self)
    }
}
