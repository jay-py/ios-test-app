//
//  ColorExtension.swift
//
//
//  Created by Jean paul on 2023-12-06.
//
// swift-format-ignore-file

import SwiftUI

extension Color {
    
    public static let themeColor = Color(#colorLiteral(red: 0.6976454854, green: 0.1156781837, blue: 0.3587750793, alpha: 1))
    
    public static func fontColor(_ ligthMode: Bool) -> Color {
        return ligthMode ? .black : .white
    }
    
    public static func backgroundColor(_ ligthMode: Bool) -> Color  {
        return ligthMode ? .white : .black
    }
}
