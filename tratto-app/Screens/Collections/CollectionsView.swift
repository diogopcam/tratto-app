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
                .toolbar {
                    toolbarContent
                }
                .background(.backgroundPrimary)
                .sheet(isPresented: $addCollection) { addCollectionView }
                .alert("Tem certeza que deseja excluir estas coleções?",
                       isPresented: $vm.showDeleteConfirmation) {
                    deleteConfirmationButtons
                }
                .task {
                    await vm.loadCollections()
                }
        }
        .navigationDestination(for: Collection.self) { collection in
            // CollectionDetail pode ter sua própria navegação interna
            CollectionDetail(collection: collection, collectionService: diContainer.collectionService)
        }
    }
}

// MARK: - View Components
private extension CollectionsView {
    var contentView: some View {
        Group {
            if vm.isLoading {
                ProgressView("Carregando...")
            } else if vm.collections.isEmpty {
                CollectionsEmptyState(addCollection: $addCollection)
                    .padding()
            } else {
                collectionsGrid
            }
        }
    }
    
    var collectionsGrid: some View {
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
                        onTap: handleCollectionTap(collection),
                        onLongPress: handleLongPress(collection)
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
    
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if vm.selectedCollections.isEmpty {
                addButton
            } else {
                deleteButton
            }
        }
    }
    
    var addButton: some View {
        Button {
            addCollection = true
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundStyle(.pink)
        }
    }
    
    var deleteButton: some View {
        Button {
            vm.showDeleteConfirmation = true
        } label: {
            Image(systemName: "trash.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundStyle(.red)
        }
    }
    
    var addCollectionView: some View {
        let addVM = AddCollectionVM(collectionService: diContainer.collectionService)
        return AddCollectionView(vm: addVM)
            .onReceive(addVM.$newCollection.compactMap { $0 }) { collection in
                vm.collections.append(collection)
            }
    }
    
    var deleteConfirmationButtons: some View {
        Group {
            Button("Cancelar", role: .cancel) { }
            Button("Excluir", role: .destructive) {
                Task { await vm.deleteSelectedCollections() }
            }
        }
    }
    
    func handleCollectionTap(_ collection: Collection) -> () -> Void {
        {
            if vm.isEditing {
                vm.toggleCollectionSelection(collection)
            } else {
                navigationPath.append(collection)
            }
        }
    }
    
    func handleLongPress(_ collection: Collection) -> () -> Void {
        {
            withAnimation {
                vm.isEditing = true
                vm.toggleCollectionSelection(collection)
            }
        }
    }
}
