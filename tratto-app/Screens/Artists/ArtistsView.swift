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
    
    @State private var currentIndex = 0
    
    init() {
        // Configuração da NavBar transparente
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        // Configuração da TabBar transparente
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithTransparentBackground()
        tabAppearance.backgroundColor = .clear
        UITabBar.appearance().standardAppearance = tabAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }
    }
    
    var body: some View {
        ZStack {
            // 0. Perfil do tatuador
            Group {
                ForEach(Array(all.enumerated())), 
                // 1. Imagem em tela cheia
                TabView(selection: $currentIndex) {
                    ForEach(Array(mockTattooArtist.portfolioImages.enumerated()), id: \.offset) { index, imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                            .tag(index)
                    }
                }
                    
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
            }
            
            // 2. Conteúdo sobreposto
            VStack {
                Spacer()
                
                // VStack de informações
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline, spacing: 12){
                        Text("Nome tatuador")
                            .font(.custom("HelveticaNeue-Bold", size: 36))
                        Text("Ele/dele")
                            .font(.custom("HelveticaNeue-Regular", size: 16))
                    }
                    Text("Endereço do tatuador")
                        .font(.custom("HelveticaNeue-Light", size: 16))
                    Text("Quanto tempo até seu endereço")
                        .font(.custom("HelveticaNeue-Light", size: 16))
                }
                .foregroundColor(.white)
                .padding(.leading, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 54)
                
                // Page control personalizado
                HStack {
                    Spacer()
                    HStack(spacing: 8) {
                        ForEach(0..<mockTattooArtist.portfolioImages.count, id: \.self) { index in
                            Circle()
                                .fill(currentIndex == index ? Color.white : Color.white.opacity(0.5))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .cornerRadius(12)
                    .padding(.bottom, 40) // Distância da TabBar
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        Tatuadores()
    }
    .tabItem {
        Label("Tatuadores", systemImage: "person.fill")
    }
}
