//
//  AddRefs.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddRefs: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    let collection: Collection
    var onSave: () -> Void // Callback para fechar e atualizar
    
    @State private var noteText: String = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    func deleteImage() {
        selectedImageData = nil
        selectedItem = nil
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                
                // Campo de anotação
                VStack(alignment: .leading, spacing: 8) {
                    Text("Insira uma anotação sobre a referência")
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                    
                    TextEditor(text: $noteText)
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
                    
                    if let data = selectedImageData {
                        ImageDisplayRef(imageData: Binding(
                            get: { data },
                            set: { newValue in
                                selectedImageData = newValue
                            }
                        )) {
                            deleteImage()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 254)
                        
                    } else {
                        ImagePickerButton(selectedItem: $selectedItem)
                            .onChange(of: selectedItem) {
                                Task {
                                    selectedImageData = nil
                                    if let item = selectedItem {
                                        if let data = try? await item.loadTransferable(type: Data.self) {
                                            selectedImageData = data
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 254)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Criar nova referência")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 38)
            .padding(.horizontal, 16)
            .background(Color.backgroundSecondary)
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
                    .buttonStyle(PlainButtonStyle())
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveReference()
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundStyle(.pink)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(selectedImageData == nil)
                }
            }
        }
    }
    
    private func saveReference() {
        guard let imageData = selectedImageData,
              let uiImage = UIImage(data: imageData) else {
            return
        }
        
        let reference = Reference(
            text: noteText.isEmpty ? nil : noteText,
            image: uiImage,
            collection: collection
        )
        
        collection.references.append(reference)
        context.insert(reference)
        
        do {
            try context.save()
            print("Referência salva com sucesso!")
            onSave() // Fecha o sheet e atualiza a lista
        } catch {
            print("Erro ao salvar referência:", error)
        }
    }
}
