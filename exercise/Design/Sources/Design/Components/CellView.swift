//
//  CellView.swift
//
//
//  Created by Jean paul on 2023-12-07.
//

import SwiftUI

public struct CellView: View {
    @Environment(\.colorScheme) private var colorScheme

    private let text: String
    private let image: UIImage

    public init(text: String, image: UIImage) {
        self.text = text
        self.image = image
    }

    public var body: some View {
        HStack(spacing: 10) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            Spacer()
            Text(text)
                .fontWeight(.medium)
                .foregroundStyle(Color.fontColor(colorScheme == .light))
                .multilineTextAlignment(.center)
            Spacer()

        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(lineWidth: 3)
                .foregroundColor(.themeColor)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(
                    color: Color.gray.opacity(0.6), radius: 3, x: 3, y: 3)
        )
    }
}

#if DEBUG
    #Preview {
        CellView(text: "The Batman Movie", image: UIImage.createImage())
    }
#endif
