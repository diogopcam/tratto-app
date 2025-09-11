//
//  StyleBadge.swift
//  tratto-app
//
//  Created by Diogo Camargo on 11/09/25.
//

import SwiftUI

struct StyleBadge: View {
    let style: String
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 6) {
            Text(style)
                .font(.subheadline)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .foregroundColor(.labelsPrimary)
            
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
            }
        }
    }
}
