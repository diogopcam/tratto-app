//
//  CollectionService.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData
import SwiftUI

@MainActor
final class CollectionService: CollectionServiceProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - CRUD Operations
    
    func fetchAllCollections() -> [Collection] {
        let descriptor = FetchDescriptor<Collection>(
            sortBy: [SortDescriptor(\.title)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func fetchCollection(by id: PersistentIdentifier) -> Collection? {
        let descriptor = FetchDescriptor<Collection>(
            predicate: #Predicate { $0.persistentModelID == id }
        )
        return try? context.fetch(descriptor).first
    }
    
    func fetchCollection(by title: String) -> Collection? {
        let descriptor = FetchDescriptor<Collection>(
            predicate: #Predicate { $0.title == title }
        )
        return try? context.fetch(descriptor).first
    }
    
    func createCollection(title: String) throws -> Collection {
        let collection = Collection(title: title)
        context.insert(collection)
        try context.save()
        return collection
    }
    
    func updateCollection(_ collection: Collection) throws {
        try context.save()
    }
    
    func deleteCollection(_ collection: Collection) throws {
        context.delete(collection)
        try context.save()
    }
    
    func deleteCollections(_ collections: Set<Collection>) throws {
        for collection in collections {
            context.delete(collection)
        }
        try context.save()
    }
    
    // MARK: - References Management
    
    func addReference(to collection: Collection, text: String?, image: UIImage) throws -> Reference {
        let reference = Reference(text: text, image: image, collection: collection)
        collection.references.append(reference)
        try context.save()
        return reference
    }
    
    func removeReference(_ reference: Reference, from collection: Collection) throws {
        collection.references.removeAll { $0.persistentModelID == reference.persistentModelID }
        context.delete(reference)
        try context.save()
    }
    
    func fetchReferences(for collection: Collection?) -> [Reference] {
        guard let collection = collection else {
            let descriptor = FetchDescriptor<Reference>(
                sortBy: [SortDescriptor(\.creationDate, order: .reverse)]
            )
            return (try? context.fetch(descriptor)) ?? []
        }
        
        return collection.references.sorted { $0.creationDate > $1.creationDate }
    }
    
    // MARK: - Bulk Operations
    
    func getCollectionsCount() -> Int {
        (try? context.fetchCount(FetchDescriptor<Collection>())) ?? 0
    }
    
    func getReferencesCount(for collection: Collection?) -> Int {
        if let collection = collection {
            return collection.references.count
        }
        
        let descriptor = FetchDescriptor<Reference>()
        return (try? context.fetchCount(descriptor)) ?? 0
    }
    
    func hasCollections() -> Bool {
        getCollectionsCount() > 0
    }
    
    // MARK: - Utilities
    
    func printAllCollections() {
        let collections = fetchAllCollections()
        print("=== Collections ===")
        for collection in collections {
            print("""
            Title: \(collection.title)
            References: \(collection.references.count)
            ---
            """)
        }
    }
}
