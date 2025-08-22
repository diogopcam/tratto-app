//
//  Tatuadores.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftUI
import SwiftData

struct Tatuadores: View {
    let mockTattooArtist = TattooArtistProfile(
        name: "Lucas Pereira",
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
