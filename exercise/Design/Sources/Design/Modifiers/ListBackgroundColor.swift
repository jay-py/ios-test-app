//
//  File.swift
//
//
//  Created by Jean paul on 2023-12-07.
//

import SwiftUI

struct ListBackgroundColor: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .background(
                Color.backgroundColor(colorScheme == .light)
                    .ignoresSafeArea(.all)
            )
    }
}

extension View {
    public func listBackgroundColor() -> some View {
        modifier(ListBackgroundColor())
    }
}
