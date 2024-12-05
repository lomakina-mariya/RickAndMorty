//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Mariya on 05.12.2024.
//

import SwiftUI
import SwiftData

@main
struct RickAndMortyApp: App {
    @State private var showSplashScreen = true
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CharacterEntity.self,
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
            if showSplashScreen {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                CharacterListView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
