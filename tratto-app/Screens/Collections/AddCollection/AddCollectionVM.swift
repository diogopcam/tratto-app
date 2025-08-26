//
//  AddCollection.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import PhotosUI

@MainActor
final class AddCollectionVM: AddCollectionVMProtocol {
    @Published var collectionName: String = ""
    @Published var selectedItems: [PhotosPickerItem] = [] {
        didSet {
            Task { await processSelectedItems() }
        }
    }
    @Published var selectedImageDatas: [Data] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var newCollection: Collection? = nil
    
    private let collectionService: CollectionServiceProtocol
    
    init(collectionService: CollectionServiceProtocol) {
        self.collectionService = collectionService
    }
    
    func addSelectedItems(_ items: [PhotosPickerItem]) async {
        selectedItems.append(contentsOf: items)
    }
    
    func deleteImage(at index: Int) {
        guard selectedImageDatas.indices.contains(index) else { return }
        selectedImageDatas.remove(at: index)
        
        if selectedItems.indices.contains(index) {
            selectedItems.remove(at: index)
        }
    }
    
    func saveCollection() async -> Bool {
        guard !collectionName.isEmpty else {
            errorMessage = "Por favor, insira um nome para a coleção"
            return false
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            // Cria a coleção
            let collection = try collectionService.createCollection(title: collectionName)
            
            // Notifica a criação
            newCollection = collection
            
            // Adiciona as referências (imagens)
            for imageData in selectedImageDatas {
                do {
                    _ = try collectionService.addReference(to: collection, text: nil, imageData: imageData)
                } catch {
                    errorMessage = "Erro ao adicionar referência: \(error.localizedDescription)"
                }
            }
            
            isLoading = false
            return true
        } catch {
            isLoading = false
            errorMessage = "Erro ao salvar coleção: \(error.localizedDescription)"
            return false
        }
    }
    
    private func processSelectedItems() async {
        var newImageDatas: [Data] = []
        
        for item in selectedItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                newImageDatas.append(data)
            }
        }
        
        await MainActor.run {
            selectedImageDatas = newImageDatas
        }
    }
}
