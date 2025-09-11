//
//  FavoriteCard.swift
//  tratto-app
//
//  Created by Diogo Camargo on 10/09/25.
//

import SwiftUI

struct FavoriteCard: View {
    let artist: TattooArtistProfile
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Imagem do tatuador
            Image(artist.portfolioImages.first ?? "avatar")
                .resizable()
                .scaledToFill()
                .frame(width: 165, height: 165) // altura fixa
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(artist.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(artist.pronoun)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                
                Text(artist.address)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 70)
            }
            
            .padding(.top, 16)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 165)
        .background(Color.black)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}


// Visualização de exemplo para testar o componente
struct FavoriteCard_Previews: PreviewProvider {
    static var previews: some View {
        let sampleArtist = TattooArtistProfile(
            name: "Lucas Pereira",
            pronoun: "Ele/dele",
            address: "Rua da Arte, 123 - São Paulo",
            distance: "15 min de você",
            bio: "Especialista em realismo e blackwork.",
            portfolioImages: ["img1", "img2", "img3"]
        )
        
        FavoriteCard(artist: sampleArtist)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.black) // Fundo preto para visualização
    }
}
