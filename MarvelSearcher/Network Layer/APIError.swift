//
//  APIError.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 09.03.2022.
//

import Foundation

/// Enumiration of API errors
enum APIError: Error {
    
    /// Impossible to form a URL
    case failedToCreateURL
    
    /// Unsuccess response from server
    case failedResponse(Error)
    
    /// Impossible to obtain auth credentials
    case invalidCredentials
    
    /// Impossible to obtain data for pagination
    case invalidPageData
    
    /// Impossible to obtain paramters
    case invalidParameters
    
    /// Error on deconding of response
    case failedToDecode(String)
    
    /// Unknown error
    case unknown
}
