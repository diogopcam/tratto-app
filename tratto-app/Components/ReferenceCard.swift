//
//  ReferenceCard.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 06/08/25.
//

import SwiftUI

struct ReferenceCard: View {
    let reference: Reference
    var action: (() -> Void)? = nil

    var image: Image {
        if let uiImage = reference.image {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "photo") // fallback
        }
    }

    var overlayText: String? {
        reference.text
    }

    var creationDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: reference.creationDate)
    }

    var body: some View {
        Button(action: { action?() }) {
            ZStack {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 223)
                    .clipped()
                    .cornerRadius(22)

                if let overlayText = overlayText {
                    ZStack {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.black.opacity(0.5), .black.opacity(0.5)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(22)

                        VStack {
                            Text(overlayText)
                                .font(.custom("HelveticaNeue-Regular", size: 16))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.top, 20)
                                .lineLimit(8)
                                .frame(maxWidth: 170, alignment: .leading)

                            Spacer()

                            Text("Ref criada em \(creationDateFormatted)")
                                .font(.custom("HelveticaNeue-Regular", size: 8))
                                .foregroundColor(.white.opacity(0.8))
                                .padding([.horizontal, .bottom], 10)
                                .padding([.vertical, .bottom], 7)
                                .frame(maxWidth: 170, alignment: .leading)
                        }
                    }
                    .frame(width: 170, height: 223)
                } else {
                    VStack {
                        Spacer()
                    }
                    .frame(width: 170, height: 223)
                    .cornerRadius(22)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 16) {
        ReferenceCard(reference: Reference(text: "Exemplo de referência", image: UIImage(named: "img2")!, collection: nil))
        ReferenceCard(reference: Reference(text: nil, image: UIImage(named: "img3")!, collection: nil))
    }
}
