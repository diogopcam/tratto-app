//
//  Collections.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//
import SwiftUI
import SwiftData

struct CollectionsView: View {
    @Environment(\.diContainer) private var diContainer
    @StateObject private var vm: CollectionsVM
    @State private var addCollection = false
    @State private var navigationPath = NavigationPath()
    
    init(vm: CollectionsVM) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    private var shouldHideTabBar: Bool {
        !vm.selectedCollections.isEmpty || vm.isEditing
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            contentView
                .navigationTitle("Coleções")
                .toolbar(shouldHideTabBar ? .hidden : .visible, for: .tabBar)
                .background(.backgroundPrimary)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        if vm.selectedCollections.isEmpty {
                            Button {
                                addCollection = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.pink)
                            }
                        } else {
                            Button {
                                vm.showDeleteConfirmation = true
                            } label: {
                                Image(systemName: "trash.circle.fill")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                .sheet(isPresented: $addCollection) {
                    AddCollectionView(vm: AddCollectionVM(collectionService: diContainer.collectionService))
                }
                .alert("Tem certeza que deseja excluir estas coleções?",
                      isPresented: $vm.showDeleteConfirmation) {
                    Button("Cancelar", role: .cancel) { }
                    Button("Excluir", role: .destructive) {
                        Task { await vm.deleteSelectedCollections() }
                    }
                }
                .task {
                    await vm.loadCollections()
                }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if vm.isLoading {
            ProgressView("Carregando...")
        } else if vm.collections.isEmpty {
            CollectionsEmptyState(addCollection: $addCollection)
                .padding()
        } else {
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ],
                    spacing: 16
                ) {
                    ForEach(vm.collections) { collection in
                        CollectionCard(
                            collection: collection,
                            isEditing: vm.isEditing,
                            isSelected: vm.selectedCollections.contains(collection),
                            onTap: {
                                if vm.isEditing {
                                    vm.toggleCollectionSelection(collection)
                                } else {
                                    navigationPath.append(collection)
                                }
                            },
                            onLongPress: {
                                withAnimation {
                                    vm.isEditing = true
                                    vm.toggleCollectionSelection(collection)
                                }
                            }
                        )
                    }
                }
                .padding()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if vm.isEditing {
                    withAnimation {
                        vm.clearSelection()
                    }
                }
            }
        }
    }
}
