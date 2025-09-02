//
//  ImageDisplay.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 06/08/25.
//


import SwiftUI

struct ImageDisplay: View {
    @Binding var imageData: Data
    let onDelete: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 113, height: 109)
                    .cornerRadius(22)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.gray, lineWidth: 0.7)
                    )
            } else {
                Color.gray
                    .frame(width: 113, height: 109)
                    .cornerRadius(22)
            }

            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .frame(width: 7, height: 7)
            }
            .offset(x: -12, y: 12)
        }
    }
}


