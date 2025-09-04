//
//  Tatuadores.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftUI
import SwiftData


struct Tatuadores: View {
    
    let all: [TattooArtistProfile] = [
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
        TattooArtistProfile(
            name: "Camila Torres",
            pronoun: "Ela/dela",
            address: "Praça das Flores, 321 - Porto Alegre",
            distance: "12 min de você",
            bio: "Colorido vibrante e estilo aquarela.",
            portfolioImages: ["img10", "img11", "img12"]
        ),
        TattooArtistProfile(
            name: "Diego Martins",
            pronoun: "Ele/dele",
            address: "Rua dos Sonhos, 654 - Belo Horizonte",
            distance: "25 min de você",
            bio: "Old school, new school e tattoos autorais.",
            portfolioImages: ["img13", "img14", "img15"]
        )
    ]
    
    let mockTattooArtist = TattooArtistProfile(
        name: "Lucas Pereira",
        pronoun: "Ele/dele",
        address: "Rua dos Sonhos, 654 - Belo Horizonte",
        distance: "25 min de você",
        bio: "Especialista em realismo e blackwork.",
        portfolioImages: ["img2", "img4"]
    )
    
    init() {
        // Pega a cor do asset e transforma em UIColor
        let color = UIColor(named: "BackgroundSecondary") ?? UIColor.blue
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    @State private var currentIndex = 0
    
    var body: some View {
        // ESSA ZStack deve ser o componente de perfil do tatuador, e o for
        ScrollView {
            VStack {
                ForEach(all) { artist in
                    TattooArtistProfileView(artist: artist)
                        .frame(height: UIScreen.main.bounds.height)
                }
            }
        }
    }
}
