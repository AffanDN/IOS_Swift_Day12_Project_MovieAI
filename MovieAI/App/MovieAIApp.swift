//
//  MovieAIApp.swift
//  MovieAI
//
//  Created by Macbook Pro on 02/05/24.
//

import SwiftUI
import FirebaseCore

@main
struct MovieAIApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
