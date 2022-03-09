//
//  ApiPageData.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 08.03.2022.
//

import Foundation

/// Model for pagination of API request
struct APIPageData {
    
    /// Standard limit for a request
    static let defaultLimit = 20
    
    /// Offset for returning elements (should be non-negative integer)
    let offset: Int
    
    /// Limit for returning elements (should be positive integer)
    let limit: Int
    
    init(offset: Int) {
        self.offset = offset
        self.limit = APIPageData.defaultLimit
    }
    
    /// Returns parameters wfor pagination
    var dictionary: [String: String] {
        ["offset": "\(offset)", "limit": "\(limit)"]
    }
}
