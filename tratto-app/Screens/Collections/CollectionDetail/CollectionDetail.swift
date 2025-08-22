//
//  CollectionDetail.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 08/08/25.
//

import SwiftUI
import SwiftData

struct CollectionDetail: View {
    @Environment(\.modelContext) private var context
    @Query var collections: [Collection]
    let collection: Collection
    
    @State private var addRefs = false
    @State private var selectedReference: Reference? = nil
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            if collection.references.isEmpty {
                Spacer()
                RefsEmptyState(addRefs: $addRefs)
                Spacer()
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                        ForEach(collection.references) { reference in
                            ReferenceCard(reference: reference) {
                                selectedReference = reference
                            }
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
                    // Botão de voltar personalizado (esquerda)
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.pink)
                        }
                    }
                    
                    // Título centralizado
                    ToolbarItem(placement: .principal) {
                        Text(collection.title)
                            .font(.custom("HelveticaNeue-Bold", size: 26))
                            .foregroundColor(.primary)
                    }
                    
                    // Botão de adicionar (direita)
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addRefs = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 44, height: 44) // Tamanho menor para melhor proporção
                                .foregroundColor(.pink)
                        }
                    }
                }
                .sheet(isPresented: $addRefs) {
                    AddRefs(collection: collection) {
                        addRefs = false
                    }
                }
                .background(
                    NavigationLink(
                        destination: selectedReference.map { ReferenceDetail(reference: $0) },
                        isActive: Binding(
                            get: { selectedReference != nil },
                            set: { if !$0 { selectedReference = nil } }
                        )
                    ) { EmptyView() }
                    .hidden()
                )
            }
        }
