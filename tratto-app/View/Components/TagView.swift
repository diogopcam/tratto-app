//
//  TagView.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 14/08/25.
//


import SwiftUI

struct TagView: View {
    let style: TattooStyle
    var isSelected: Bool
    var isInteractive: Bool
    var onTap: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isInteractive ? (isSelected ? "checkmark" : "xmark") : "checkmark")
                .foregroundColor(.white)
                .font(.system(size: 12))
            
            Text(style.rawValue)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 8)
        .frame(minWidth: 80, minHeight: 32) // largura mínima para não ficar muito apertado
        .background(.tagGray)
        .cornerRadius(8)
        .contentShape(Rectangle())
        .onTapGesture {
            if isInteractive {
                onTap?()
            }
        }
    }
}

struct TattooTagPreview: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 12)], spacing: 12) {
                ForEach(TattooStyle.allCases) { style in
                    TagView(
                        style: style,
                        isSelected: Bool.random(),
                        isInteractive: true,
                        onTap: {}
                    )
                }
            }
            .padding()
        }
        .background(Color.black) // só para destacar as tags no preview
    }
}

#Preview {
    TattooTagPreview()
}


#Preview {
    TattooTagPreview()
}
