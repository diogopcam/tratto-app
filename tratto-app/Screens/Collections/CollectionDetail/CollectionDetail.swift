//
//  CollectionDetail.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 08/08/25.
//

import SwiftUI
import SwiftData

struct CollectionDetail: View {
    @StateObject private var vm: CollectionDetailVM
    @State private var addRefs = false
    @Environment(\.dismiss) private var dismiss
    
    init(collection: Collection, collectionService: CollectionServiceProtocol) {
        _vm = StateObject(wrappedValue: CollectionDetailVM(collection: collection, collectionService: collectionService))
    }
    
    var body: some View {
            contentView
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.pink)
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("Coleção")
                            .font(.custom("HelveticaNeue-Bold", size: 26))
                            .foregroundColor(.primary)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addRefs = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.pink)
                        }
                    }
                }
                .sheet(isPresented: $addRefs) {
                    // AddRefs(collection: vm.collection) { addRefs = false }
                }
                .navigationDestination(for: Reference.self) { reference in
                    ReferenceDetail(reference: reference)
                }
                .alert("Erro", isPresented: .constant(vm.errorMessage != nil), presenting: vm.errorMessage) { error in
                    Button("OK", role: .cancel) {
                        vm.errorMessage = nil
                    }
                } message: { error in
                    Text(error)
                }
        }
    
    @ViewBuilder
    private var contentView: some View {
        if vm.references.isEmpty {
            Spacer()
            RefsEmptyState(addRefs: $addRefs)
            Spacer()
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                    ForEach(vm.references) { reference in
                        ReferenceCard(reference: reference) {
                            // Navegação programática usando NavigationPath
//                            navigationPath.append(reference)
                            vm.selectedReference = reference
                        }
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
}
