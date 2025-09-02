//
//  TattooArtistProfile.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//
import SwiftUI

struct TattooArtistProfile: Identifiable {
    let id = UUID()
    let name: String
    let pronoun: String
    let address: String
    let distance: String
    let bio: String
    let portfolioImages: [String]
}
