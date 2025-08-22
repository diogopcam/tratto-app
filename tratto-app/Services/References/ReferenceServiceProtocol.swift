//
//  ReferenceServiceProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import Foundation
import UIKit

@MainActor
protocol ReferenceServiceProtocol {
    // CRUD Referências
    func fetchReferences() -> [Reference]
    func fetchReferences(for collection: Collection?) -> [Reference]
    func createReference(text: String?, image: UIImage, collection: Collection?) throws -> Reference
    func updateReference(_ reference: Reference) throws
    func deleteReference(_ reference: Reference) throws
    
    // Processamento de Imagens
    func compressImage(_ image: UIImage, quality: CGFloat) -> Data
}
