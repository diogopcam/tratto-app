//
//  CollectionDetailVMProtocol.swift
//  tratto-app
//
//  Created by Diogo Camargo on 26/08/25.
//


import SwiftUI
import SwiftData

@MainActor
protocol CollectionDetailVMProtocol: ObservableObject {
    var references: [Reference] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var selectedReference: Reference? { get set }
    
    func loadReferences()
    func deleteReference(_ reference: Reference) async
    func addReference(_ reference: Reference)
    func clearSelection()
}
