//
//  CollectionServiceProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData
import SwiftUI

@MainActor
protocol CollectionServiceProtocol {
    // MARK: - CRUD Operations
    func fetchAllCollections() -> [Collection]
    func fetchCollection(by id: PersistentIdentifier) -> Collection?
    func fetchCollection(by title: String) -> Collection?
    func createCollection(title: String) throws -> Collection
    func updateCollection(_ collection: Collection) throws
    func deleteCollection(_ collection: Collection) throws
    func deleteCollections(_ collections: Set<Collection>) throws
    
    // MARK: - References Management
    func addReference(to collection: Collection, text: String?, image: UIImage) throws -> Reference
    func removeReference(_ reference: Reference, from collection: Collection) throws
    func fetchReferences(for collection: Collection?) -> [Reference]
    
    // MARK: - Bulk Operations
    func getCollectionsCount() -> Int
    func getReferencesCount(for collection: Collection?) -> Int
    func hasCollections() -> Bool
}
