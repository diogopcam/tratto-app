//
//  TabBar.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftUI


struct TabBar: View {
    @Environment(\.diContainer) private var container
    
    var body: some View {
        TabView {
            Tatuadores()
            .tabItem {
                Label("Tatuadores", systemImage: "person.2.fill")
            }
            
            CollectionsView(vm: CollectionsVM(collectionService: container.collectionService))
            .tabItem {
                Label("Coleções", systemImage: "photo.fill")
            }
            
            FavoritesView(vm: FavoritesVM(favoritesService: container.favoritesService))
            .tabItem {
                Label("Favoritos", systemImage: "heart.fill")
            }
        }
        .tint(.pink)
        .foregroundStyle(.pink)
    }
}
