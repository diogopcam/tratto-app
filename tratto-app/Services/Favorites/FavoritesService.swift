//
//  FavoritesService.swift
//  tratto-app
//
//  Created by Diogo Camargo on 10/09/25.
//

import SwiftData
import SwiftUI

@MainActor
final class FavoritesService: FavoritesServiceProtocol {
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Fetch Favorites
    func fetchAllFavorites() -> [TattooArtist] {
        let descriptor = FetchDescriptor<TattooArtist>(
            sortBy: [SortDescriptor(\.name)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
}
