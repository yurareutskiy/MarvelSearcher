//
//  CharacterService.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 08.03.2022.
//

import Foundation

protocol CharacterServiceProtocol: AnyObject {
    func fetchCharacters(with offset: Int, search: String?) async throws -> BaseResponseDataModel<CharacterDataModel>
}

final class CharacterService: CharacterServiceProtocol {
    
    let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchCharacters(with offset: Int, search: String?) async throws -> BaseResponseDataModel<CharacterDataModel> {
        let pageData = APIPageData(offset: offset)
        var apiRoute: APIRoute
        if let search = search {
            apiRoute = .searchCharacters(search)
        } else {
            apiRoute = .charactersList
        }
        let result: BaseResponseModel<CharacterDataModel> = try await apiManager.get(from: apiRoute, pageData: pageData)
        return result.data
    }
    
    func getCharacter(by id: Int) -> CharacterDataModel? {
        return nil
    }
    
}
