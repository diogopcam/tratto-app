//
//  ReferenceDetail.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 09/08/25.
//

import SwiftUI
import SwiftData

struct ReferenceDetail: View {
    let reference: Reference
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext  // <== injeta contexto SwiftData
    
    @State private var isEditing = false
    @State private var editableText: String
    @State private var textHeight: CGFloat
    @State private var showDeleteConfirmation = false
    
    let font = UIFont(name: "Helvetica Neue", size: 16) ?? UIFont.systemFont(ofSize: 16)
    
    init(reference: Reference) {
        self.reference = reference
        _editableText = State(initialValue: reference.text ?? "")
        
        let initialHeight = ReferenceDetail.calculateTextHeight(
            text: reference.text ?? "",
            font: font,
            width: UIScreen.main.bounds.width - 32
        )
        _textHeight = State(initialValue: initialHeight)
    }
    
    var creationDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: reference.creationDate)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let uiImage = reference.image {
                        Image(uiImage: uiImage)
                            .resizable()
                                .scaledToFill()
                                .ignoresSafeArea(.all)
                            .shadow(radius: 4)
                            .padding(.top, 8)
                    }
                    
                    if isEditing {
                        TextEditor(text: $editableText)
                            .font(.custom("HelveticaNeue-Regular", size: 16))
                            .foregroundColor(.primary)
                            .padding(.leading, 16)
                            .frame(height: textHeight)
                            .cornerRadius(8)
                            .onChange(of: editableText) {
                                textHeight = ReferenceDetail.calculateTextHeight(
                                    text: editableText,
                                    font: font,
                                    width: UIScreen.main.bounds.width - 32
                                )
                            }
                    } else {
                        Text(editableText.isEmpty ? "Toque para adicionar texto..." : editableText)
                            .font(.custom("HelveticaNeue-Regular", size: 16))
                            .foregroundColor(.primary)
                            .padding(.vertical, 4)
                            .padding(.horizontal)
                            .onTapGesture {
                                isEditing = true
                            }
                    }
                    
                    HStack {
                        Text("Criada em \(creationDateFormatted)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.pink)
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button("Salvar") {
                        isEditing = false
                        saveText()
                    }
                    .font(.headline)
                } else {
                    Button {
                        showDeleteConfirmation = true
                    } label: {
                        Image(systemName: "trash.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .font(.system(size: 44, weight: .thin))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.red, .black)
                        
                            .shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 4)
                        }
                    .alert("Tem certeza que deseja excluir esta referência?", isPresented: $showDeleteConfirmation) {
                        Button("Excluir", role: .destructive) {
                            deleteReference()
                        }
                        Button("Cancelar", role: .cancel) { }
                    }
                }
            }
        }

        .toolbar(.hidden, for: .tabBar)
    }
    
    static func calculateTextHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let textStorage = NSTextStorage(string: text, attributes: [.font: font])
        let textContainer = NSTextContainer(size: CGSize(width: width, height: .greatestFiniteMagnitude))
        let layoutManager = NSLayoutManager()
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        layoutManager.glyphRange(for: textContainer)
        
        let height = layoutManager.usedRect(for: textContainer).height
        return max(height + 20, 44)
    }
    
    private func saveText() {
        do {
            try modelContext.transaction {
                reference.text = editableText
            }
            print("Texto salvo via SwiftData: \(editableText)")
        } catch {
            print("Erro ao salvar texto: \(error.localizedDescription)")
        }
    }
    
    private func deleteReference() {
        do {
            try modelContext.transaction {
                modelContext.delete(reference)
            }
            print("Referência excluída com sucesso")
            dismiss()
        } catch {
            print("Erro ao excluir referência: \(error.localizedDescription)")
        }
    }
}
