//
//  ReferenceViewModelProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 30/08/25.
//


//
//  ReferenceViewModelProtocol.swift
//  tratto-app
//
//  Created by Your Name on 21/08/25.
//

import SwiftUI
import SwiftData

@MainActor
protocol ReferenceDetailVMProtocol: ObservableObject {
    var reference: Reference { get }
    var editableText: String { get set }
    var textHeight: CGFloat { get set }
    var isEditing: Bool { get set }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    var creationDateFormatted: String { get }
    
    func saveText() async -> Bool
    func deleteReference() async -> Bool
    func calculateTextHeight(text: String, width: CGFloat) -> CGFloat
}

