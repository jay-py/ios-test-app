//
//  File.swift
//  
//
//  Created by Jean paul on 2023-12-07.
//
import SwiftUI

struct AdaptiveNavigationBar: ViewModifier {

    private let isLightModeOn: Bool
    
    init(isLightModeOn: Bool) {
        self.isLightModeOn = isLightModeOn
        UINavigationBar.appearance().tintColor = UIColor(Color.themeColor)
        UISearchBar.appearance().setImage(searchBarImage(), for: .search, state: .normal)
        UISearchBar.appearance().tintColor = UIColor(Color.themeColor)
    }
    
    private func searchBarImage() -> UIImage {
        let image = UIImage(systemName: "magnifyingglass")
        return image!.withTintColor(UIColor(Color.themeColor), renderingMode: .alwaysOriginal)
    }

    func body(content: Content) -> some View {
        content
            .preferredColorScheme(isLightModeOn ? .light : .dark)
    }

}

extension View {
    public func cutomNavigationBar(isLightModeOn: Bool) -> some View {
        modifier(AdaptiveNavigationBar(isLightModeOn: isLightModeOn))
    }
}
