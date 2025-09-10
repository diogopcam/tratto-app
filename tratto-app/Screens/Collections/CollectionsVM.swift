//
//  CollectionsViewModel.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftUI

@MainActor
final class CollectionsVM: CollectionsVMProtocol {
    @Published var collections: [Collection] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isEditing: Bool = false
    @Published var selectedCollections: Set<Collection> = []
    @Published var showDeleteConfirmation: Bool = false
    
    private let collectionService: any CollectionServiceProtocol
    
    init(collectionService: any CollectionServiceProtocol) {
        self.collectionService = collectionService
    }
    
    func loadCollections() async {
        isLoading = true
        errorMessage = nil
        
        await MainActor.run {
            self.collections = self.collectionService.fetchAllCollections()
            self.isLoading = false
        }
    }
    
    func createCollection(title: String) async {
        do {
            let collection = try collectionService.createCollection(title: title)
            await MainActor.run {
                self.collections.append(collection)
            }
        } catch {
            await MainActor.run {
                errorMessage = "Erro ao criar coleção: \(error.localizedDescription)"
            }
        }
    }
    
    func deleteSelectedCollections() async {
        do {
            try collectionService.deleteCollections(selectedCollections)
            await MainActor.run {
                collections.removeAll { selectedCollections.contains($0) }
                selectedCollections.removeAll()
                isEditing = false
                showDeleteConfirmation = false
            }
        } catch {
            await MainActor.run {
                errorMessage = "Erro ao excluir coleções: \(error.localizedDescription)"
            }
        }
    }
    
    func toggleCollectionSelection(_ collection: Collection) {
        if selectedCollections.contains(collection) {
            selectedCollections.remove(collection)
        } else {
            selectedCollections.insert(collection)
        }
    }
    
    func clearSelection() {
        selectedCollections.removeAll()
        isEditing = false
    }
}
