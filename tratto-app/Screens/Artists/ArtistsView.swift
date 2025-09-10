//
//  Tatuadores.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//

import SwiftUI

struct Tatuadores: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isLiked: Bool = false   // controla o estado do botão
    
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
    
    init() {
        let color = UIColor(named: "BackgroundSecondary") ?? UIColor.blue
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) { UITabBar.appearance().scrollEdgeAppearance = appearance }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topTrailing) {
                
                // 🔹 Conteúdo (feed vertical com swipe)
                VStack(spacing: 0) {
                    ForEach(all.indices, id: \.self) { index in
                        TattooArtistProfileView(artist: all[index])
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
                .offset(y: -CGFloat(currentIndex) * geo.size.height + dragOffset)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation.height
                        }
                        .onEnded { value in
                            let threshold = geo.size.height / 30
                            var newIndex = currentIndex
                            
                            if value.translation.height < -threshold {
                                newIndex = min(newIndex + 1, all.count - 1)
                            } else if value.translation.height > threshold {
                                newIndex = max(newIndex - 1, 0)
                            }
                            
                            withAnimation(.spring(
                                response: 0.45,
                                dampingFraction: 0.80,
                                blendDuration: 0.25
                            )) {
                                currentIndex = newIndex
                            }
                        }
                )
                
                // 🔥 Botões alinhados no canto superior direito
                HStack(spacing: 12) {
                    Button {
                        print("❤️ botão de curtir")
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }

                    Button {
                        print("⚙️ botão de filtro")
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
                
                .padding(.top, 50) // distancia do topo (abaixo da Dynamic Island)
                .padding(.trailing, 20) // distancia da lateral direita
            }
        }
        .ignoresSafeArea()
    }
}
