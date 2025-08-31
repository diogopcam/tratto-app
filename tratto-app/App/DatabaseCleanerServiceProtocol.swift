//
//  DatabaseCleanerServiceProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData
import SwiftUI

@MainActor
protocol DatabaseCleanerServiceProtocol {
    func clearAllData() throws
    func clearTattooArtists() throws
    func clearCollections() throws
    func clearReferences() throws
}

@MainActor
final class DatabaseCleanerService: DatabaseCleanerServiceProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func clearAllData() throws {
        try clearTattooArtists()
        try clearCollections()
        try clearReferences()
        print("✅ Todos os dados foram removidos")
    }
    
    func clearTattooArtists() throws {
        let descriptor = FetchDescriptor<TattooArtist>()
        let artists = try context.fetch(descriptor)
        
        for artist in artists {
            context.delete(artist)
        }
        
        try context.save()
        print("✅ Tattoo artists removidos: \(artists.count)")
    }
    
    func clearCollections() throws {
        let descriptor = FetchDescriptor<Collection>()
        let collections = try context.fetch(descriptor)
        
        for collection in collections {
            context.delete(collection)
        }
        
        try context.save()
        print("✅ Collections removidas: \(collections.count)")
    }
    
    func clearReferences() throws {
        let descriptor = FetchDescriptor<Reference>()
        let references = try context.fetch(descriptor)
        
        for reference in references {
            context.delete(reference)
        }
        
        try context.save()
        print("✅ References removidas: \(references.count)")
    }
}
