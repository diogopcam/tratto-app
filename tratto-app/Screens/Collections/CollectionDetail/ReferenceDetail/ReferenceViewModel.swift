//
//  ReferenceViewModel.swift
//  tratto-app
//
//  Created by Diogo Camargo on 30/08/25.
//


//
//  ReferenceViewModel.swift
//  tratto-app
//
//  Created by Your Name on 21/08/25.
//

import SwiftUI
import SwiftData

@MainActor
final class ReferenceDetailVM: ReferenceDetailVMProtocol {
    @Published var reference: Reference
    @Published var editableText: String
    @Published var textHeight: CGFloat
    @Published var isEditing: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let referenceService: ReferenceServiceProtocol
    private let font = UIFont(name: "Helvetica Neue", size: 16) ?? UIFont.systemFont(ofSize: 16)
    
    init(reference: Reference, referenceService: ReferenceServiceProtocol) {
        self.reference = reference
        self.editableText = reference.text ?? ""
        self.referenceService = referenceService
        
        // Calcula altura inicial do texto
        let initialHeight = Self.calculateTextHeight(
            text: reference.text ?? "",
            font: font,
            width: UIScreen.main.bounds.width - 32
        )
        self.textHeight = initialHeight
    }
    
    var creationDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: reference.creationDate)
    }
    
    func saveText() async -> Bool {
        isLoading = true
        errorMessage = nil
        
        do {
            reference.text = editableText
            try referenceService.updateReference(reference)
            
            await MainActor.run {
                isLoading = false
                isEditing = false
            }
            return true
            
        } catch {
            await MainActor.run {
                isLoading = false
                errorMessage = "Erro ao salvar texto: \(error.localizedDescription)"
            }
            return false
        }
    }
    
    func deleteReference() async -> Bool {
        isLoading = true
        errorMessage = nil
        
        do {
            try referenceService.deleteReference(reference)
            
            await MainActor.run {
                isLoading = false
            }
            return true
            
        } catch {
            await MainActor.run {
                isLoading = false
                errorMessage = "Erro ao excluir referência: \(error.localizedDescription)"
            }
            return false
        }
    }
    
    func calculateTextHeight(text: String, width: CGFloat) -> CGFloat {
        return Self.calculateTextHeight(text: text, font: font, width: width)
    }
    
    // Método estático para cálculo de altura
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
}
