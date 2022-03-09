//
//  Routes.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 09.03.2022.
//

import Foundation

/// Object to form a route for API request.
enum APIRoute {
    
    /// Search characters with a text
    case searchCharacters(String)
    
    /// List of all characters
    case charactersList
}

extension APIRoute {
    
    /// Path for route
    var route: String {
        switch self {
        case .charactersList, .searchCharacters:
            return "/public/characters"
        }
    }
    
    /// Supported version for route
    var version: String {
        switch self {
        case .charactersList, .searchCharacters:
            return "/v1"
        }
    }
    
    /// Additioinal parameters for route
    var parameters: [String: String]? {
        switch self {
        case .searchCharacters(let searchText):
            return ["nameStartsWith": searchText]
        default: return nil
        }
    }
    
    /// Full path for route
    var urlPath: String {
        "\(BaseURL.current)\(version)\(route)"
    }
}
