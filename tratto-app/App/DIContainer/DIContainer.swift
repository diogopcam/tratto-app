//
//  DIContainer.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData
import SwiftUICore

@MainActor
final class DIContainer {
    let modelContainer: ModelContainer
    //    let tattooArtistService: TattooArtistServiceProtocol
    let collectionService: CollectionServiceProtocol
    let referenceService: ReferenceServiceProtocol
    let favoritesService: FavoritesServiceProtocol
    var databaseCleaner: DatabaseCleanerServiceProtocol?
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        //        self.tattooArtistService = TattooArtistService(context: modelContainer.mainContext)
        self.collectionService = CollectionService(context: modelContainer.mainContext)
        self.referenceService = ReferenceService(context: modelContainer.mainContext)
        self.favoritesService = FavoritesService(context: modelContainer.mainContext)
        self.databaseCleaner = DatabaseCleanerService(context: modelContainer.mainContext)
    }
    
    // Init vazio para fallback
    init() {
        self.modelContainer = try! ModelContainer(
            for: Schema([]),
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        collectionService = CollectionService(context: modelContainer.mainContext)
        referenceService = ReferenceService(context: modelContainer.mainContext)
        favoritesService = FavoritesService(context: modelContainer.mainContext)
    }
    
    // Método conveniente para limpar tudo
    func clearAllData() throws {
        try databaseCleaner?.clearAllData()
    }
}

private struct DIContainerKey: EnvironmentKey {
    static let defaultValue: DIContainer = {
        MainActor.assumeIsolated {
            do {
                // Tenta criar container PERSISTENTE primeiro
                let modelContainer = try ModelContainer(
                    for: appSchema,
                    configurations: ModelConfiguration(
                        isStoredInMemoryOnly: false
                    )
                )
                return DIContainer(modelContainer: modelContainer)
                
            } catch {
                print("⚠️ Failed to create persistent container: \(error)")
                
                // Fallback 1: Container em MEMÓRIA
                do {
                    let fallbackContainer = try ModelContainer(
                        for: appSchema, // ← Usa o MESMO schema
                        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
                    )
                    print("✅ Using in-memory fallback container")
                    return DIContainer(modelContainer: fallbackContainer)
                    
                } catch {
                    // Fallback 2: Container VAZIO (último recurso)
                    print("⚠️ Failed to create fallback container: \(error)")
                    print("⚠️ Using empty DIContainer as last resort")
                
                    return DIContainer() // ← Fallback final
                }
            }
        }
    }()
}

extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}

