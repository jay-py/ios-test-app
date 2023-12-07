//
//  DetailsView.swift
//
//
//  Created by Jean paul on 2023-12-07.
//

import SwiftUI

public struct DetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @State private var sheetActive = true
    @State private var cardHeight: CGFloat = 0
    private let title: String
    private let imageUrl: URL?
    private let genre: String
    private let released: String
    private let plot: String

    public init(title: String, imageUrl: URL?, genre: String, released: String, plot: String) {
        self.title = title
        self.imageUrl = imageUrl
        self.genre = genre
        self.released = released
        self.plot = plot
    }

    public var body: some View {
        content
            .navigationBarBackButtonHidden()
    }

    var content: some View {
        VStack(spacing: 0) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .ignoresSafeArea()
        .sheet(isPresented: $sheetActive) {
            cardView
                .interactiveDismissDisabled()
                .presentationDetents([.fraction(self.cardHeight)])
        }
    }

    var cardView: some View {
        VStack(spacing: 0) {
            backButton
            Spacer()
            titleView
            divider
            metaView
            divider
            plotView
            divider
            Spacer()
        }
        .padding()
        .background(
            GeometryReader { gp -> Color in
                DispatchQueue.main.async {
                    let desiredHeight = (gp.size.height + 20) / UIScreen.main.bounds.height
                    if cardHeight == 0 {
                        self.cardHeight = desiredHeight
                    }
                }
                return Color.clear
            }
        )
    }

    var titleView: some View {
        Text(self.title)
            .font(Font.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.fontColor(colorScheme == .light))
            .padding(.top)
            .fixedSize(horizontal: false, vertical: true)
    }

    var divider: some View {
        Color.themeColor
            .frame(height: 1)
            .frame(maxWidth: .infinity)
            .padding(.top)
            .fixedSize(horizontal: false, vertical: true)
    }

    var metaView: some View {
        HStack {
            Text(self.released)
            Spacer()
            Text(self.genre)
        }
        .font(Font.headline)
        .fontWeight(.semibold)
        .foregroundStyle(Color.fontColor(colorScheme == .light))
        .padding(.top)
        .fixedSize(horizontal: false, vertical: true)
    }

    var plotView: some View {
        Text(self.plot)
            .font(Font.body)
            .fontWeight(.regular)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.fontColor(colorScheme == .light))
            .padding(.top)
            .fixedSize(horizontal: false, vertical: true)
    }

    var backButton: some View {
        HStack {
            Button(
                action: {
                    sheetActive.toggle()
                    dismiss()
                },
                label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("back_button")
                            .font(Font.callout)
                            .fontWeight(.regular)
                    }
                    .foregroundStyle(Color.themeColor)
                })
            Spacer()
        }
        .padding(.top)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    DetailsView(
        title: "The Batman",
        imageUrl: URL(
            string:
                "https://m.media-amazon.com/images/M/MV5BM2MyNTAwZGEtNTAxNC00ODVjLTgzZjUtYmU0YjAzNmQyZDEwXkEyXkFqcGdeQXVyNDc2NTg3NzA@._V1_SX300.jpg"
        ),
        genre: "Action",
        released: "04 Mar 2022",
        plot:
            "When a sadistic serial killer begins murdering key political figures in Gotham, Batman is forced to investigate the city\'s hidden corruption and question his family\'s involvement."
    )
}
