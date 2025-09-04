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
            // Aba 1: Tatuadores
//            NavigationStack {
            Tatuadores()
//            }
            .tabItem {
                Label("Tatuadores", systemImage: "person.2.fill")
            }
            
            // Aba 2: Coleções
//            NavigationStack {
                CollectionsView(vm: CollectionsVM(collectionService: container.collectionService))
//            }
            .tabItem {
                Label("Coleções", systemImage: "photo.fill")
            }
            
//            // Categories Tab
//            NavigationStack {
//                CategoriesView(
//                    vm: CategoriesVM(
//                        apiService: container.apiService
//                    )
//                )
//            }
//            .tabItem {
//                Label("Categories", systemImage: "square.grid.2x2.fill")
//            }
            
            // Aba 3: Favoritos
//            NavigationStack {
//                Favorites(modelContext: <#ModelContext#>) // Não precisa passar modelContext manualmente!
//            }
            .tabItem {
                Label("Favoritos", systemImage: "heart.fill")
            }
        }
        .tint(.pink)
        .foregroundStyle(.yellow)
    }
}
