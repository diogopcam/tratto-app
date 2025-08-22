//
//  TattooArtistService.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData
import SwiftUI

@MainActor
final class TattooArtistService: TattooArtistServiceProtocol {
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - CRUD Operations
    func fetchAllArtists() -> [TattooArtist] {
        let descriptor = FetchDescriptor<TattooArtist>(
            sortBy: [SortDescriptor(\.name)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func fetchArtist(by name: String) -> TattooArtist? {
        let descriptor = FetchDescriptor<TattooArtist>(
            predicate: #Predicate { $0.name == name } // ← Busca exata
        )
        return try? context.fetch(descriptor).first
    }
    
    func fetchArtist(by id: UUID) -> TattooArtist? {
        let descriptor = FetchDescriptor<TattooArtist>(
            predicate: #Predicate { $0.id == id } // ← Busca exata
        )
        return try? context.fetch(descriptor).first
    }
    
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
    ) throws -> TattooArtist {
        let artist = TattooArtist(
            name: name,
            age: age,
            bio: bio,
            profilePicture: profilePicture,
            styles: styles,
            portfolioImages: portfolioImages,
            address: address,
            phoneNumber: phoneNumber,
            instagramURL: instagramURL,
            experienceYears: experienceYears,
            isFavorite: false
        )
        
        context.insert(artist)
        try context.save()
        return artist
    }
    
    func updateArtist(_ artist: TattooArtist) throws {
        try context.save()
    }
    
    func deleteArtist(_ artist: TattooArtist) throws {
        context.delete(artist)
        try context.save()
    }
    
    // MARK: - Favorites
    func toggleFavorite(_ artist: TattooArtist) throws {
        artist.isFavorite.toggle()
        try context.save()
    }
    
    func getFavoriteArtists() -> [TattooArtist] {
        let descriptor = FetchDescriptor<TattooArtist>(
            predicate: #Predicate { $0.isFavorite == true },
            sortBy: [SortDescriptor(\.name)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func isArtistFavorite(_ artist: TattooArtist) -> Bool {
        artist.isFavorite
    }
    
    // MARK: - Filtering
    
    
    func filterArtists(by style: String) -> [TattooArtist] {
        let descriptor = FetchDescriptor<TattooArtist>(
            predicate: #Predicate { artist in
                artist.styles.contains(style) // ← Contains em array é suportado
            },
            sortBy: [SortDescriptor(\.name)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func filterArtists(by experienceRange: ClosedRange<Int>) -> [TattooArtist] {
        let descriptor = FetchDescriptor<TattooArtist>(
            predicate: #Predicate {
                $0.experienceYears >= experienceRange.lowerBound &&
                $0.experienceYears <= experienceRange.upperBound
            },
            sortBy: [SortDescriptor(\.experienceYears, order: .reverse)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func filterArtistsByName(by searchText: String) -> [TattooArtist] {
        let allArtists = fetchAllArtists()
        
        if searchText.isEmpty {
            return allArtists
        }
        
        return allArtists.filter { artist in
            artist.name.localizedCaseInsensitiveContains(searchText) ||
            artist.bio.localizedCaseInsensitiveContains(searchText) ||
            artist.styles.contains { $0.localizedCaseInsensitiveContains(searchText) } ||
            artist.address.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func getUniqueStyles() -> [String] {
        let allArtists = fetchAllArtists()
        let allStyles = allArtists.flatMap { $0.styles }
        return Array(Set(allStyles)).sorted()
    }
    
    // MARK: - Portfolio Management
    func addPortfolioImage(_ imageName: String, to artist: TattooArtist) throws {
        artist.portfolioImages.append(imageName)
        try context.save()
    }
    
    func removePortfolioImage(_ imageName: String, from artist: TattooArtist) throws {
        artist.portfolioImages.removeAll { $0 == imageName }
        try context.save()
    }
    
    // MARK: - Utilities
    func printAllArtists() {
        let artists = fetchAllArtists()
        print("=== Tattoo Artists ===")
        for artist in artists {
            print("""
            ID: \(artist.id)
            Name: \(artist.name)
            Age: \(artist.age)
            Experience: \(artist.experienceYears) years
            Styles: \(artist.styles.joined(separator: ", "))
            Favorite: \(artist.isFavorite)
            ---
            """)
        }
    }
}
