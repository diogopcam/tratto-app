//
//  AppSchema.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData

public let appSchema = Schema([
    TattooArtist.self,
    Reference.self,
    Collection.self
])
