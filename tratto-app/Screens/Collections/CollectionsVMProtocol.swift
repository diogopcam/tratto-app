//
//  CollectionsViewModelProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//


import SwiftData
import SwiftUI

@MainActor
protocol CollectionsVMProtocol: ObservableObject {
    var collections: [Collection] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var isEditing: Bool { get set }
    var selectedCollections: Set<Collection> { get set }
    var showDeleteConfirmation: Bool { get set }
    
    func loadCollections() async
    func createCollection(title: String) async
    func deleteSelectedCollections() async
    func toggleCollectionSelection(_ collection: Collection)
    func clearSelection()
}
