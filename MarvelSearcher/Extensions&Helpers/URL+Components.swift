//
//  URL+Components.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 21.02.2022.
//

import Foundation

extension URL {
    
    enum URLComponentsError: Error {
        case invalidInitialURL
        case failedParsingResultURL
    }

    /// Update an existed URL with dictionary of parameters
    func appended(components: [String: String]) throws -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else {
            throw URLComponentsError.invalidInitialURL
        }

        /// Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        for component in components {
            /// Create query item
            let item = URLQueryItem(name: component.key, value: component.value)
            
            /// Append the new query item in the existing query items array
            queryItems.append(item)
        }

        /// Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        /// Returns the url from new url components
        guard let url = urlComponents.url else {
            throw URLComponentsError.failedParsingResultURL
        }
        return url
    }
}
