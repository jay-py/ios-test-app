//
//  BackgroundModifier.swift
//
//
//  Created by Jean paul on 2023-12-06.
//

import SwiftUI

struct BackgroundColorModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [.themeColor, .themeColor.opacity(0.4)], startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(.all)
            )
    }
}

extension View {
    public func backgroundColor() -> some View {
        modifier(BackgroundColorModifier())
    }
}
