//
//  URLResponseExtension.swift
//
//
//  Created by Jean paul on 2023-12-06.
//

import Foundation

extension URLResponse {

    var isOk: Bool {
        guard let httpResponse = self as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else { return false }
        return true
    }

    var status: Int? {
        guard let httpResponse = self as? HTTPURLResponse
        else { return nil }
        return httpResponse.statusCode
    }

    var prettyPrint: String {
        if let url = self.url,
            let status = self.status
        {
            return String("Status: \(status) for url: \(url)")
        } else {
            return self.description
        }
    }

}
