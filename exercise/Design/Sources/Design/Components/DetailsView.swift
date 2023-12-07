//
//  File.swift
//  
//
//  Created by Jean paul on 2023-12-07.
//

import SwiftUI

public struct DetailsView: View {
    let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
    }
}
