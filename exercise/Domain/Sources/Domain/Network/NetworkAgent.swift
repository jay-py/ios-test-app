//
//  NetworkAgent.swift
//
//
//  Created by Jean paul on 2023-12-06.
//

import SwiftUI

class NetworkAgent {

    static func getURL(path: String, parameters: Parameters? = nil) -> URL? {
        guard let url = URL(string: path),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else { return nil }

        if let params = parameters {
            urlComponents.queryItems = [URLQueryItem]()
            for param in params {
                urlComponents.queryItems?.append(URLQueryItem(name: param.key, value: param.value))
            }
        }
        return urlComponents.url
    }

    static func getRequestWithHeaders(
        url: URL, method: HttpMethod, contentType: ContentType? = nil
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let contentType = contentType {
            request.setValue(contentType.value, forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}

extension NetworkAgent {

    static func fetchData<T: BaseModel>(
        path: APIEndpoints,
        _ method: HttpMethod = .GET,
        query: Parameters? = nil,
        requestBody: Any? = nil,
        responseType: T.Type
    ) async throws -> T {
        #if DEBUG
            print(">> debug")
            if [1].contains(1) {
                return try! JSONDecoder().decode(responseType, from: T.mockData)
            }
        #endif
        guard let url = getURL(path: path.value, parameters: query)
        else { throw NetworkError.urlError }

        var request = getRequestWithHeaders(url: url, method: method)
        if [.POST, .PATCH, .PUT].contains(method),
            let encodAble = requestBody as? Encodable
        {
            request.httpBody = try JSONEncoder().encode(encodAble)
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        if !response.isOk {
            throw NetworkError.unknown(response.prettyPrint)
        }
        guard let responseObject = try? JSONDecoder().decode(responseType, from: data)
        else { throw NetworkError.parseError }
        return responseObject
    }
}

extension NetworkAgent {

    typealias Parameters = [String: String]

    enum HttpMethod: String {
        case GET = "GET"
        case POST = "POST"
        case PATCH = "PATCH"
        case DELETE = "DELETE"
        case PUT = "PUT"
    }

    enum ContentType {
        case json

        var value: String {
            switch self {
                case .json:
                    return "application/json"
            }
        }
    }

    enum NetworkError: Error {
        case urlError
        case parseError
        case unknown(String)

        var message: String {
            switch self {
                case .unknown(let message):
                    return message
                default:
                    return "No message!"
            }
        }
    }

}
