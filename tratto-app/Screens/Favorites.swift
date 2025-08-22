//
// Favoritos.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//
//
//import SwiftUI
//import SwiftData
//
//struct Favorites: View {
//    @Environment(\.modelContext) private var modelContext
//    @State private var viewModel: TattooArtistViewModel
//    
//    init(modelContext: ModelContext) {
//        _viewModel = State(initialValue: TattooArtistViewModel(modelContext: modelContext))
//    }
//    
//    var body: some View {
//        List(viewModel.artists) { artist in
//            ArtistRow(artist: artist)
//        }
//        .navigationTitle("Todos os Tatuadores")
//        .onAppear {
//            viewModel.mockInitialData()
//            viewModel.fetchAllArtists()
//        }
//    }
//}
//
//struct ArtistRow: View {
//    let artist: TattooArtist
//    
//    var body: some View {
//        HStack(spacing: 12) {
//            Image(artist.profilePicture)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 50, height: 50)
//                .clipShape(Circle())
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text(artist.name)
//                    .font(.headline)
//                Text(artist.bio)
//                    .font(.subheadline)
//                    .lineLimit(1)
//                Text(artist.styles.joined(separator: ", "))
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            }
//        }
//        .padding(.vertical, 8)
//    }
//}
//
//// Pré-visualização com contexto
//struct Favorites_Previews: PreviewProvider {
//    static var previews: some View {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try! ModelContainer(for: TattooArtist.self, configurations: config)
//        
//        return NavigationStack {
//            Favorites(modelContext: container.mainContext)
//        }
//        .modelContainer(container)
//    }
//}
