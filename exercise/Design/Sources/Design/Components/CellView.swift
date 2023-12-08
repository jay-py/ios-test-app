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
    private let imageUrl: URL?

    public init(text: String, imageUrl: URL?) {
        self.text = text
        self.imageUrl = imageUrl
    }

    public var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 100)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            Spacer()
            Text(text)
                .fontWeight(.medium)
                .foregroundStyle(Color.fontColor(colorScheme == .light))
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
                    color: (colorScheme == .dark ? Color.white : Color.gray).opacity(0.6),
                    radius: 3, x: 3, y: 3)
        )
    }
}
