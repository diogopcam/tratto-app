//
//  Referencia.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 08/08/25.
//

import SwiftData
import SwiftUI

@Model
final class Reference: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()   // necessário para SwiftData
    var text: String?
    var imageData: Data
    var creationDate: Date
    var collection: Collection?
    
    var image: UIImage? {
        UIImage(data: imageData)
    }

    init(text: String?, imageData: Data, collection: Collection?) {
        self.text = text
        self.imageData = imageData
        self.creationDate = Date()
        self.collection = collection
    }
}
