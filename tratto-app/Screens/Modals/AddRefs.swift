//
//  AddRefs.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import PhotosUI

struct AddRefs: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm: AddRefsVM
    
    init(collection: Collection,
         collectionService: CollectionServiceProtocol,
         onSave: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: AddRefsVM(
            collection: collection,
            collectionService: collectionService,
            onSave: onSave
        ))
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                
                // Campo de anotação
                VStack(alignment: .leading, spacing: 8) {
                    Text("Insira uma anotação sobre a referência")
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                    
                    TextEditor(text: $vm.noteText)
                        .background(Color(.systemGray6))
                        .frame(height: 202)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .tint(.pink)
                        .multilineTextAlignment(.leading)
                }
                
                // Seletor de imagem
                VStack(alignment: .leading, spacing: 8) {
                    Text("Selecionar uma foto da sua galeria")
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                    
                    if let data = vm.selectedImageData {
                        ImageDisplayRef(imageData: Binding(
                            get: { data },
                            set: { newValue in
                                vm.selectedImageData = newValue
                            }
                        )) {
                            vm.deleteImage()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 254)
                        
                    } else {
                        ImagePickerButton(selectedItem: $vm.selectedItem)
                            .onChange(of: vm.selectedItem) { oldItem, newItem in
                                Task {
                                    await vm.loadImage()
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 254)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 38)
            .padding(.horizontal, 16)
            .background(Color.backgroundSecondary)
            .navigationTitle("Criar nova referência")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundStyle(.gray)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        Task {
                            await vm.saveReference()
                        }
                    } label: {
                        if vm.isLoading {
                            ProgressView()
                                .frame(width: 44, height: 44)
                        } else {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .foregroundStyle(.pink)
                        }
                    }
                    .disabled(vm.selectedImageData == nil || vm.isLoading)
                }
            }
            .alert("Erro", isPresented: .constant(vm.errorMessage != nil)) {
                Button("OK", role: .cancel) {
                    vm.errorMessage = nil
                }
            } message: { 
                Text(vm.errorMessage ?? "")
            }
        }
    }
}
