//
//  FavoritesServiceProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 10/09/25.
//

import SwiftData
import SwiftUI

@MainActor
protocol FavoritesServiceProtocol {
    func fetchAllFavorites() -> [TattooArtist]
}
