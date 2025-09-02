//
//  RefsEmptyState.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI

// Protocolo, não classe
struct RefsEmptyState: View {
    
    @Binding var addRefs: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 24) {
                Image(systemName: "photo.fill")
                    .resizable()
                    .frame(width: 92, height: 72)
                    .foregroundColor(.gray)
                
                VStack(spacing: 16) {
                    Text("Você ainda não adicionou nenhuma referência nessa coleção.")
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
    RefsEmptyState(addRefs: .constant(false))
}
