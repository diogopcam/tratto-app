//
//  Favoritos.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @StateObject private var vm: FavoritesVM
    
    init(vm: FavoritesVM) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        Text("Favoritos") // ou seu layout completo
    }
}
