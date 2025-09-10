//
//  FavoritesVM.swift
//  tratto-app
//
//  Created by Diogo Camargo on 10/09/25.
//

import SwiftUI

@MainActor
final class FavoritesVM: FavoritesVMProtocol {
    @Published var favorites: [TattooArtistProfile] = [
        TattooArtistProfile(
            name: "Lucas Pereira",
            pronoun: "Ele/dele",
            address: "Rua da Arte, 123 - São Paulo",
            distance: "15 min de você",
            bio: "Especialista em realismo e blackwork.",
            portfolioImages: ["img1", "img2", "img3"]
        ),
        TattooArtistProfile(
            name: "Ana Souza",
            pronoun: "Ela/dela",
            address: "Av. Brasil, 456 - Rio de Janeiro",
            distance: "20 min de você",
            bio: "Minimalismo, fine line e traços delicados.",
            portfolioImages: ["img4", "img5", "img6"]
        ),
        TattooArtistProfile(
            name: "Rafael Lima",
            pronoun: "Ele/dele",
            address: "Rua Central, 789 - Curitiba",
            distance: "8 min de você",
            bio: "Geométrico, tribal e mandalas.",
            portfolioImages: ["img7", "img8", "img9"]
        ),
    ]

    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let favoritesService: any FavoritesServiceProtocol
    
    init(favoritesService: any FavoritesServiceProtocol) {
        self.favoritesService = favoritesService
    }
    
    func loadFavorites() async {
        isLoading = true
        errorMessage = nil
        
        await MainActor.run {
//            self.favorites = self.favoritesService.fetchAllFavorites()
            self.isLoading = false
        }
    }
}
