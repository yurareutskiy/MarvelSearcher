//
//  AuthService.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 21.02.2022.
//

import Foundation

/// Authenticating service for API
protocol AuthServiceProtocol: AnyObject {
    
    /// Public API key
    var apiKey: String { get }
    
    /// Private API key
    var privateKey: String { get }
    
    /// Returns a dictionary with credentials for request
    var authCredentials: [String: String] { get }
}

final class AuthService: AuthServiceProtocol {
    let apiKey: String
    let privateKey: String
    
    init(apiKey: String, privateKey: String) {
        self.apiKey = apiKey
        self.privateKey = privateKey
    }
    
    var authCredentials: [String: String] {
        let timeStamp = String(Int(Date().timeIntervalSince1970))
        let hash = hash(from: timeStamp) ?? ""
        return ["apikey": apiKey, "hash": hash, "ts": timeStamp]
    }
    
    private func hash(from timeStamp: String) -> String? {
        let sourceString = "\(timeStamp)\(privateKey)\(apiKey)"
        return sourceString.md5Hash
    }
}
