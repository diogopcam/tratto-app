//
//  ReferenceService.swift
//  tratto-app
//
//  Created by Your Name on 21/08/25.
//

import SwiftData
import SwiftUI

@MainActor
final class ReferenceService: ReferenceServiceProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchReference(by id: PersistentIdentifier) -> Reference? {
        let descriptor = FetchDescriptor<Reference>(
            predicate: #Predicate { $0.persistentModelID == id }
        )
        return try? context.fetch(descriptor).first
    }
    
    func fetchReferences(for collection: Collection?) -> [Reference] {
        if let collection = collection {
            return collection.references.sorted { $0.creationDate > $1.creationDate }
        }
        
        let descriptor = FetchDescriptor<Reference>(
            sortBy: [SortDescriptor(\.creationDate, order: .reverse)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func updateReference(_ reference: Reference) throws {
        try context.save()
    }
    
    func deleteReference(_ reference: Reference) throws {
        context.delete(reference)
        try context.save()
    }
    
    func getReferencesCount() -> Int {
        (try? context.fetchCount(FetchDescriptor<Reference>())) ?? 0
    }
    
    func addReference(to collection: Collection?, text: String?, imageData: Data) throws -> Reference {
        let reference = Reference(text: text, imageData: imageData, collection: collection)
        
        if let collection = collection {
            collection.references.append(reference)
        } else {
            context.insert(reference)
        }
        
        try context.save()
        return reference
    }
}
