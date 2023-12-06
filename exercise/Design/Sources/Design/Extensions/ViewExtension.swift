//
//  ViewExtension.swift
//
//
//  Created by Jean paul on 2023-12-06.
//

import SwiftUI

extension View {
    public func endEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
