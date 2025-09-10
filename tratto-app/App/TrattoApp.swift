//
//  tratto_appApp.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData
import SwiftUI

@main
struct TrattoApp: App {
    var diContainer: DIContainer
    
    init() {
        do {
            let container = try ModelContainer(for: appSchema)
            self.diContainer = DIContainer(modelContainer: container)
        } catch {
            print("Erro ao criar container persistente: \(error)")
            let fallback = try! ModelContainer(
                for: appSchema,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            self.diContainer = DIContainer(modelContainer: fallback)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabBar()
                .environment(\.diContainer, diContainer)
                .modelContainer(diContainer.modelContainer)
                .preferredColorScheme(.dark)
        }
    }
}
