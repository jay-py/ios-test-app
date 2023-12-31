//
//  BaseModel.swift
//
//
//  Created by Jean paul on 2023-12-06.
//

import Foundation

protocol BaseModel: Codable, Identifiable, Equatable {
    #if DEBUG
        static var mockData: Data! { get }
    #endif
}
