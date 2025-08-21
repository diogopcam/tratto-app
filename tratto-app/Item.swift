//
//  Item.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
