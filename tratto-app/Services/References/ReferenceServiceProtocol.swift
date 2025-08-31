//
//  ReferenceServiceProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData
import SwiftUI

@MainActor
protocol ReferenceServiceProtocol {
    func fetchReference(by id: PersistentIdentifier) -> Reference?
    func updateReference(_ reference: Reference) throws
    func deleteReference(_ reference: Reference) throws
    func getReferencesCount() -> Int
    func fetchReferences(for collection: Collection?) -> [Reference]
    func addReference(to collection: Collection?, text: String?, imageData: Data) throws -> Reference
}
