//
//  ImagePickerButton.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 06/08/25.
//

import SwiftUI
import PhotosUI

struct ImagePickerButton: View {
    
    @Binding var selectedItem: PhotosPickerItem?

    var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            VStack {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.white)
                    .font(.system(size: 44, weight: .light))
            }
            .frame(width: 375, height: 254)
            .background(.black)
            .cornerRadius(22)
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(.gray, lineWidth: 0.7)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

//#Preview {
//    AddRefs()
//}
