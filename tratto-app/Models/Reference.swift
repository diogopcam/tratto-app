//
//  Referencia.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 08/08/25.
//


import SwiftData
import SwiftUI

@Model
class Reference {
    var text: String?
    var imageData: Data
    var creationDate: Date
    var collection: Collection?
    
    var image: UIImage? {
        UIImage(data: imageData)
    }

    init(text: String?, image: UIImage, collection: Collection?) {
        self.text = text
        self.imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
        self.creationDate = Date()
        self.collection = collection
    }
}
