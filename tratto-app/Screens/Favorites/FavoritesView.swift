//
//  Favoritos.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @StateObject private var vm: FavoritesVM
    
    init(vm: FavoritesVM) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView("Carregando favoritos...")
                } else if let error = vm.errorMessage {
                    VStack(spacing: 8) {
                        Text("Erro: \(error)")
                            .foregroundColor(.red)
                        Button("Tentar novamente") {
                            Task { await vm.loadFavorites() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else if vm.favorites.isEmpty {
                    Text("Você ainda não tem favoritos ❤️")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(vm.favorites, id: \.id) { artist in
                                FavoriteCard(artist: artist)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Favoritos")
        }
    }
}

