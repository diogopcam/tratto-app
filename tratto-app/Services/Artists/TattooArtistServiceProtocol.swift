//
//  TattooArtistServiceProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData
import SwiftUI

@MainActor
protocol TattooArtistServiceProtocol {
    // MARK: - CRUD Operations
    func fetchAllArtists() -> [TattooArtist]
    func fetchArtist(by id: UUID) -> TattooArtist?
    func fetchArtist(by name: String) -> TattooArtist?
    func createArtist(
        name: String,
        age: Int,
        bio: String,
        profilePicture: String,
        styles: [String],
        portfolioImages: [String],
        address: String,
        phoneNumber: String,
        instagramURL: String,
        experienceYears: Int
    ) throws -> TattooArtist
    func updateArtist(_ artist: TattooArtist) throws
    func deleteArtist(_ artist: TattooArtist) throws
    
    // MARK: - Favorites
    func toggleFavorite(_ artist: TattooArtist) throws
    func getFavoriteArtists() -> [TattooArtist]
    func isArtistFavorite(_ artist: TattooArtist) -> Bool
    
    // MARK: - Filtering
    func filterArtists(by style: String) -> [TattooArtist]
    
    func filterArtists(by experienceRange: ClosedRange<Int>) -> [TattooArtist]
    
    func filterArtistsByName(by searchText: String) -> [TattooArtist]
    
    func getUniqueStyles() -> [String]
    
    // MARK: - Portfolio Management
    func addPortfolioImage(_ imageName: String, to artist: TattooArtist) throws
    func removePortfolioImage(_ imageName: String, from artist: TattooArtist) throws
}
