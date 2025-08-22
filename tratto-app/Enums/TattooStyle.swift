//
//  TattooStyle.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//


enum TattooStyle: String, CaseIterable, Identifiable {
    case aquarela = "Aquarela"
    case blackwork = "Blackwork"
    case fineLine = "Fine Line"
    case freehand = "Freehand"
    case lettering = "Lettering"
    case minimalista = "Minimalista"
    case oldschool = "Oldschool"
    case oriental = "Oriental"
    case pontilhismo = "Pontilhismo"
    case realismo = "Realismo"
    case surrealismo = "Surrealismo"
    case tribal = "Tribal"
    
    var id: String { rawValue }
}
