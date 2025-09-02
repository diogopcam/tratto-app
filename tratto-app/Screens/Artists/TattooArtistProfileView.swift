//
//  TattooArtistProfileView.swift
//  tratto-app
//
//  Created by Diogo Camargo on 02/09/25.
//
import SwiftUI

struct TattooArtistProfileView: View {
    let artist: TattooArtistProfile
    
    var body: some View {
        VStack(spacing: 20) {
            // Informações do artista
            VStack(alignment: .leading, spacing: 5) {
                Text(artist.name)
                    .font(.title)
                    .bold()
                Text(artist.pronoun)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(artist.address)
                    .font(.subheadline)
                Text(artist.distance)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(artist.bio)
                    .font(.body)
                    .padding(.top, 5)
            }
            .padding(.horizontal)
            
            // Scroll horizontal das imagens do portfólio
            TabView {
                ForEach(artist.portfolioImages, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                        .clipped()
                        .cornerRadius(12)
                        .padding(.horizontal, 10)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: UIScreen.main.bounds.height * 0.5)
        }
        .frame(height: UIScreen.main.bounds.height)
    }
}
