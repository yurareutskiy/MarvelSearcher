//
//  APIManager.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 21.02.2022.
//

import Foundation

/// API Manager allows to load data with API requests
protocol APIManagerProtocol: AnyObject {
    
    /// Get requests without pagination
    func get<T: Codable>(from urlRoute: APIRoute) async throws -> BaseResponseModel<T>
    
    /// Get requests with pagination
    func get<T: Codable>(from urlRoute: APIRoute, pageData: APIPageData?) async throws -> BaseResponseModel<T>
}

final class APIManager: APIManagerProtocol {
    
    private let session: URLSession
    private let authService: AuthServiceProtocol?
    
    init(session: URLSession = URLSession.shared, authService: AuthServiceProtocol?) {
        self.session = session
        self.authService = authService
    }
    
    func get<T>(from urlRoute: APIRoute) async throws -> BaseResponseModel<T> where T : Decodable, T : Encodable {
        try await get(from: urlRoute, pageData: nil)
    }
    
    func get<T: Codable>(from urlRoute: APIRoute, pageData: APIPageData?) async throws -> BaseResponseModel<T> {
        guard var url = URL(string: urlRoute.urlPath) else {
            throw APIError.failToCreateURL
        }
        
        /// Add auth credentials if existed
        if let credentials = authService?.authCredentials {
            do {
                let newURL = try url.appended(components: credentials)
                url = newURL
            } catch {
                throw APIError.invalidCredentials
            }
        }
        
        /// Add request parameters if existed
        if let parameters = urlRoute.parameters {
            do {
                let newURL = try url.appended(components: parameters)
                url = newURL
            } catch {
                throw APIError.invalidParameters
            }
        }
        
        /// Add pagination if existed
        if let pageData = pageData {
            do {
                let newURL = try url.appended(components: pageData.dictionary)
                url = newURL
            } catch {
                throw APIError.invalidPageData
            }
        }

        let (data, _) = try await session.data(from: url)
        let decodedData = try JSONDecoder().decode(BaseResponseModel<T>.self, from: data)
        return decodedData
    }
}
