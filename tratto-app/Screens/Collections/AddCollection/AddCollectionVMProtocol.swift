//
//  AddCollectionViewModelProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 21/08/25.
//
import SwiftUI
import _PhotosUI_SwiftUI

@MainActor
protocol AddCollectionVMProtocol: ObservableObject {
    var collectionName: String { get set }
    var selectedItems: [PhotosPickerItem] { get set }
    var selectedImageDatas: [Data] { get set }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func addSelectedItems(_ items: [PhotosPickerItem]) async
    func deleteImage(at index: Int)
    func saveCollection() async -> Bool
}
