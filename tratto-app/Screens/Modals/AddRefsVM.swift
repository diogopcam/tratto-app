//
//  AddRefsVM.swift
//  tratto-app
//
//  Created by Diogo Camargo on 26/08/25.
//


//
//  AddRefsVM.swift
//

import SwiftUI
import PhotosUI

@MainActor
final class AddRefsVM: ObservableObject {
    @Published var noteText: String = ""
    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedImageData: Data?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let collection: Collection
    private let collectionService: CollectionServiceProtocol
    private let onSave: () -> Void
    
    init(collection: Collection, 
         collectionService: CollectionServiceProtocol,
         onSave: @escaping () -> Void) {
        self.collection = collection
        self.collectionService = collectionService
        self.onSave = onSave
    }
    
    func loadImage() async {
        guard let item = selectedItem else { return }
        
        do {
            if let data = try await item.loadTransferable(type: Data.self) {
                selectedImageData = data
            }
        } catch {
            errorMessage = "Erro ao carregar imagem: \(error.localizedDescription)"
        }
    }
    
    func deleteImage() {
        selectedImageData = nil
        selectedItem = nil
    }
    
    func saveReference() async {
        guard let imageData = selectedImageData else {
            errorMessage = "Selecione uma imagem para salvar"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await collectionService.addReference(
                to: collection,
                text: noteText.isEmpty ? nil : noteText,
                imageData: imageData
            )
            
            await MainActor.run {
                isLoading = false
                onSave()
            }
            
        } catch {
            await MainActor.run {
                isLoading = false
                errorMessage = "Erro ao salvar referência: \(error.localizedDescription)"
            }
        }
    }
}
