//
//  Secrets.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 08.03.2022.
//

import Foundation

/// Simple option to store a pair of credentials (avoid it in production app)
enum Secrets {
    enum MarvelAPI {
        static let apiKey = "f486cd798aec958c8c0962d72d53f126"
        static let privateKey = "65681b8f8f2630ac856cf9311150d97efefd5b60"
    }
}
