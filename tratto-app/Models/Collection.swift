//
//  Colecao.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 08/08/25.
//


import SwiftData
import Foundation

@Model
final class Collection {
    var title: String
    var references: [Reference] = []

    init(title: String) {
        self.title = title
    }
}
 
