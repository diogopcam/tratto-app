//
//  TattooArtistViewModel.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftData
import SwiftUI

@Observable
class TattooArtistVM {
    private var modelContext: ModelContext
    var artists: [TattooArtist] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchAllArtists() {
        do {
            let descriptor = FetchDescriptor<TattooArtist>(sortBy: [SortDescriptor(\.name)])
            artists = try modelContext.fetch(descriptor)
            print("Tatuadores carregados: \(artists.count)") // Debug
        } catch {
            print("Erro ao buscar tatuadores:", error)
        }
    }
    
    func mockInitialData() {
        let count = (try? modelContext.fetchCount(FetchDescriptor<TattooArtist>())) ?? 0
        guard count == 0 else { return }
        
        print("Criando dados mockados...") // Debug
        
        let mockArtists = [
            TattooArtist(
                name: "Lucas Pereira",
                age: 32,
                bio: "Especialista em realismo e blackwork",
                profilePicture: "img1",
                styles: ["Realismo", "Blackwork"],
                portfolioImages: ["img1", "img2", "img3"],
                address: "Rua das Artes, 123 - SP",
                phoneNumber: "+5511999999999",
                instagramURL: "@lucastattoo",
                experienceYears: 10
            ),
            // ... (outros tatuadores mockados)
        ]
        
        mockArtists.forEach { modelContext.insert($0) }
        do {
            try modelContext.save()
            print("Dados mockados salvos com sucesso!") // Debug
        } catch {
            print("Erro ao salvar mock:", error)
        }
    }
}
