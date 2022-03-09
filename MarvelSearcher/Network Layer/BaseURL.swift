//
//  BaseURL.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 09.03.2022.
//

import Foundation

/// Switcher for URLs. There's possibility to extend a list for additional base URLs. Use 'current' for returning active base URL.
enum BaseURL: CaseIterable {
    case production
    
    var url: String {
        switch self {
        case .production:
            return "https://gateway.marvel.com"
        }
    }
    
    static var current: String {
        BaseURL.production.url
    }
}
