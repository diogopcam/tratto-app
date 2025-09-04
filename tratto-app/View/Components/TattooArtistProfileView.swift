//
//  TattooArtistProfileView.swift
//  tratto-app
//
//  Created by Diogo Camargo on 04/09/25.
//

import SwiftUI


struct TattooArtistProfileView: View {
    let artist: TattooArtistProfile
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(Array(artist.portfolioImages.enumerated()), id: \.offset) { index, imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline, spacing: 12){
                        Text(artist.name)
                            .font(.custom("HelveticaNeue-Bold", size: 36))
                        Text(artist.pronoun)
                            .font(.custom("HelveticaNeue-Regular", size: 16))
                    }
                    Text(artist.address)
                        .font(.custom("HelveticaNeue-Light", size: 16))
                    Text(artist.distance)
                        .font(.custom("HelveticaNeue-Light", size: 16))
                }
                .foregroundColor(.white)
                .padding(.leading, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 54)
                
                HStack {
                    Spacer()
                    HStack(spacing: 8) {
                        ForEach(0..<artist.portfolioImages.count, id: \.self) { index in
                            Circle()
                                .fill(currentIndex == index ? Color.white : Color.white.opacity(0.5))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .cornerRadius(12)
                    .padding(.bottom, 40)
                    Spacer()
                }
            }
            .offset(y: -90)
        }
    }
}
