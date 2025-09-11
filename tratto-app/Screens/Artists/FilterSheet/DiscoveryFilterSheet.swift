//
//  DiscoveryFilterSheet.swift
//  tratto-app
//
//  Created by Diogo Camargo on 11/09/25.
//

import SwiftUI

struct FilterSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var maxDistance: Double = 10
    @State private var selectedStyles: [String] = ["Blackwork", "Fine Line", "Realismo"]
    @State private var experienceYears: Int = 10
    @State private var selectedGender: String? = nil
    
    private let styles = ["Blackwork", "Fine Line", "Realismo", "Aquarela", "Tribal"]
    private let genders = ["Masculino", "Feminino", "Outro"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 35) {
                    
                    // Localização
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sua Localização")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.labelsPrimary)
                        HStack {
                            Text("Rua Wolfram Metzler, 503")
                                .foregroundColor(.labelsPrimary)
                                .font(.system(size: 14, weight: .regular))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.labelsPrimary)
                        }
                        .padding(.vertical, 4)
                    }
                    
                    // Distância
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Distância máxima")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.labelsPrimary)
                        HStack {
                            Slider(value: $maxDistance, in: 1...50, step: 1)
                            Text("\(Int(maxDistance))km")
                                .foregroundColor(.gray)
                                .tint(.pink)
                        }
                    }
                    
                    // Estilos
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Estilo")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.labelsPrimary)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 8)], spacing: 8) {
                            ForEach(selectedStyles, id: \.self) { style in
                                StyleBadge(style: style) {
                                    selectedStyles.removeAll { $0 == style }
                                }
                            }
                        }
                    }
                    
                    // Tempo de experiência
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tempo de experiência")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.labelsPrimary)
                        HStack {
                            Text("\(experienceYears) anos")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.labelsPrimary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.labelsPrimary)
                            
                        }
                        .padding(.vertical, 4)
                    }
                    
                    // Gênero
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Gênero")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.labelsPrimary)
                        HStack {
                            Text(selectedGender ?? "Selecione sua preferência")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.labelsPrimary)
                            
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.labelsPrimary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding()
                .padding(.top, 8)
            }
            .background(.backgroundSheet)
            .navigationTitle("Filtro de descoberta")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .foregroundColor(.white)
//                            .padding(8)
//                            .frame(width: 44, height: 44)
//                            .background(
//                                Circle()
//                                    .fill(Color.gray)
//                            )
//                    }
//                }
//            }
        }
    }
}

#Preview {
    FilterSheet()
}
