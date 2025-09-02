//
//  CollectionsEmptyState.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI

// Protocolo, não classe
struct CollectionsEmptyState: View {
    
    @Binding var addCollection: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 24) {
                Image(systemName: "folder.fill")
                    .resizable()
                    .frame(width: 92, height: 72)
                    .foregroundColor(.gray)
                
                VStack(spacing: 16) {
                    Text("Você ainda não criou nenhuma coleção.")
                        .font(.custom("HelveticaNeue-Medium", size: 20))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: 277)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
    }
}

#Preview {
    CollectionsEmptyState(addCollection: .constant(false))
}
