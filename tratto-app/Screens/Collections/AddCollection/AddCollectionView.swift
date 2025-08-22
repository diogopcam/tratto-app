//
//  AddCollectionView.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//


//
//  AddCollectionView.swift
//  tratto-app
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import PhotosUI

struct AddCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm: AddCollectionVM
    
    init(vm: AddCollectionVM){
        _vm = StateObject(wrappedValue: vm)
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                // Campo de nome
                nameField
                
                // Seletor de fotos
                photoSelectorSection
                
                // Grid de imagens
                photosGrid
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Criar nova pasta")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 38)
            .padding(.horizontal, 16)
            .background(Color.backgroundSecondary)
            .toolbar { toolbarItems }
            .overlay {
                if vm.isLoading {
                    loadingOverlay
                }
            }
            .alert("Erro", isPresented: .constant(vm.errorMessage != nil), presenting: vm.errorMessage) { error in
                Button("OK", role: .cancel) {
                    vm.errorMessage = nil
                }
            } message: { error in
                Text(error)
            }
        }
    }
    
    // MARK: - Components
    private var nameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Insira o nome da sua pasta")
                .font(.custom("HelveticaNeue-Bold", size: 16))
            
            TextField(" ", text: $vm.collectionName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray, lineWidth: 1)
                )
                .tint(.pink)
        }
    }
    
    private var photoSelectorSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Selecionar fotos da galeria")
                .font(.custom("HelveticaNeue-Bold", size: 16))
            
            HStack(alignment: .center, spacing: 12) {
                // ✅ CORRETO - PhotosPicker com Binding direto + ImageActionButton genérico
                PhotosPicker(
                    selection: $vm.selectedItems, // ← Binding AQUI, não no componente
                    maxSelectionCount: 20,
                    matching: .images
                ) {
                    ImageActionButton() // ← Componente genérico sem parâmetros
                }
                
                if vm.selectedImageDatas.indices.contains(0) {
                    ImageDisplay(
                        imageData: $vm.selectedImageDatas[0],
                        onDelete: { vm.deleteImage(at: 0) }
                    )
                }
                
                if vm.selectedImageDatas.indices.contains(1) {
                    ImageDisplay(
                        imageData: $vm.selectedImageDatas[1],
                        onDelete: { vm.deleteImage(at: 1) }
                    )
                }
            }
        }
    }
    
    private var photosGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
            ForEach(vm.selectedImageDatas.indices.dropFirst(2), id: \.self) { index in
                ImageDisplay(
                    imageData: $vm.selectedImageDatas[index],
                    onDelete: { vm.deleteImage(at: index) }
                )
            }
        }
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundStyle(.gray)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    Task {
                        let success = await vm.saveCollection()
                        if success {
                            dismiss()
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundStyle(.pink)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(vm.collectionName.isEmpty || vm.isLoading)
            }
        }
    }
    
    private var loadingOverlay: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack {
                ProgressView("Salvando...")
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(10)
            }
        }
    }
}
