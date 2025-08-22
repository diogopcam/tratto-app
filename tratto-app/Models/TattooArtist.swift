//
//  TattooArtist.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//

import SwiftData
import SwiftUI

@Model
final class TattooArtist {
    var id = UUID()
    var name: String
    var age: Int
    var bio: String
    var profilePicture: String // Nome da imagem nos assets
    var styles: [String] // Estilos como strings
    var portfolioImages: [String] // Nomes das imagens
    var address: String
    var phoneNumber: String
    var instagramURL: String
    var experienceYears: Int
    var isFavorite: Bool // Novo campo para favoritos
    
    init(name: String, age: Int, bio: String, profilePicture: String, styles: [String], portfolioImages: [String], address: String, phoneNumber: String, instagramURL: String, experienceYears: Int, isFavorite: Bool = false) {
        self.name = name
        self.age = age
        self.bio = bio
        self.profilePicture = profilePicture
        self.styles = styles
        self.portfolioImages = portfolioImages
        self.address = address
        self.phoneNumber = phoneNumber
        self.instagramURL = instagramURL
        self.experienceYears = experienceYears
        self.isFavorite = isFavorite
    }
}
