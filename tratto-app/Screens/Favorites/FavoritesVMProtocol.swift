//
//  FavoritesVMProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 10/09/25.
//

import SwiftData
import SwiftUI

@MainActor
protocol FavoritesVMProtocol: ObservableObject {
    var favorites: [TattooArtistProfile] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadFavorites() async
}
