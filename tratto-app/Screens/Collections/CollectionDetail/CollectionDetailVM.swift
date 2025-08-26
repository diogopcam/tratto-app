//
//  CollectionDetailVM.swift
//  tratto-app
//
//  Created by Diogo Camargo on 26/08/25.
//


import SwiftUI

// ViewModel com logs detalhados
@MainActor
final class CollectionDetailVM: ObservableObject {
    @Published private(set) var references: [Reference] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var selectedReference: Reference? = nil
    
    let collection: Collection
    private let collectionService: CollectionServiceProtocol
    
    init(collection: Collection, collectionService: CollectionServiceProtocol) {
        print("🔄 CollectionDetailVM INIT")
        self.collection = collection
        self.collectionService = collectionService
        
        print("📋 Collection Info:")
        print("   - Title: \(collection.title)")
        print("   - ID: \(collection.persistentModelID)")
        print("   - Has Context: \(collection.modelContext != nil)")
        print("   - Direct Refs: \(collection.references.count)")
        
        loadReferences()
    }
    
    func loadReferences() {
        print("🔄 loadReferences() called")
        isLoading = true
        errorMessage = nil
        
        print("🔍 Buscando referências para: \(collection.title)")
        
        // Verificação crítica do contexto
        if collection.modelContext == nil {
            print("❌ CRÍTICO: Collection não tem ModelContext!")
            print("❌ Isso significa que a collection foi desconectada do banco de dados")
        } else {
            print("✅ Collection tem ModelContext válido")
        }
        
        references = collectionService.fetchReferences(for: collection)
        
        print("📊 Resultado do fetch:")
        print("   - Referências retornadas: \(references.count)")
        for (index, ref) in references.enumerated() {
            print("     \(index + 1). \(ref.text ?? "Sem texto") - ID: \(ref.persistentModelID)")
        }
        
        isLoading = false
        print("✅ loadReferences() completed")
    }
}
