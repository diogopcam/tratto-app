//
//  ReferenceDetail.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 09/08/25.
//

import SwiftUI
import SwiftData

struct ReferenceDetail: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm: ReferenceDetailVM
    @State private var showDeleteConfirmation: Bool = false
    var onDelete: (() -> Void)?
    
    init(vm: ReferenceDetailVM, onDelete: (() -> Void)? = nil) {
        _vm = StateObject(wrappedValue: vm)
        self.onDelete = onDelete
    }
    
    private func handleDelete() {
        Task {
            let success = await vm.deleteReference()
            if success {
                onDelete?()
                dismiss()
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    referenceImage
                    textEditorSection
                    creationDateSection
                }
                .frame(maxWidth: .infinity)
            }
            
            if vm.isLoading { loadingOverlay }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar { toolbarItems }
        .toolbar(.hidden, for: .tabBar)
        .alert("Erro", isPresented: .constant(vm.errorMessage != nil), presenting: vm.errorMessage) { error in
            Button("OK", role: .cancel) { vm.errorMessage = nil }
        } message: { error in
            Text(error)
        }
        .alert("Tem certeza que deseja excluir esta referência?",
               isPresented: $showDeleteConfirmation) {
            Button("Excluir", role: .destructive) {
                handleDelete()
            }
            Button("Cancelar", role: .cancel) { }
        }
    }
    
    // MARK: - Components
    private var referenceImage: some View {
        Group {
            if let uiImage = vm.reference.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                    .shadow(radius: 4)
                    .padding(.top, 8)
            }
        }
    }
    
    private var textEditorSection: some View {
        Group {
            if vm.isEditing {
                TextEditor(text: $vm.editableText)
                    .font(.custom("HelveticaNeue-Regular", size: 16))
                    .foregroundColor(.primary)
                    .padding(.leading, 16)
                    .frame(height: vm.textHeight)
                    .cornerRadius(8)
                    .onChange(of: vm.editableText) {
                        vm.textHeight = vm.calculateTextHeight(
                            text: vm.editableText,
                            width: UIScreen.main.bounds.width - 32
                        )
                    }
            } else {
                Text(vm.editableText.isEmpty ? "Toque para adicionar texto..." : vm.editableText)
                    .font(.custom("HelveticaNeue-Regular", size: 16))
                    .foregroundColor(.primary)
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                    .onTapGesture { vm.isEditing = true }
            }
        }
    }
    
    private var creationDateSection: some View {
        HStack {
            Text("Criada em \(vm.creationDateFormatted)")
                .font(.footnote)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    @ToolbarContentBuilder
    private var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.pink)
            }
        }

        ToolbarItem(placement: .navigationBarTrailing) {
            if vm.isEditing {
                Button("Salvar") {
                    Task { await vm.saveText() }
                }
                .font(.headline)
            } else {
                Button {
                    showDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundStyle(.red)
                }
            }
        }
    }
    
    private var loadingOverlay: some View {
        Color.black.opacity(0.4)
            .ignoresSafeArea()
            .overlay {
                ProgressView().scaleEffect(1.5)
            }
    }
}
