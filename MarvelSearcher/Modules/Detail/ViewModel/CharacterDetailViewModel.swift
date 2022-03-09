//
//  CharacterDetailViewModel.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 08.03.2022.
//

import Foundation

/// View model for detailed represantation of character
final class CharacterDetailViewModel {
    let displayModel: CharacterDetailDisplayModel
    
    init(character: CharacterDataModel) {
        var thumbnailURL: URL? = nil
        if var thumbnailPath = character.thumbnail?.fullPath {
            /// In case of insecured http url, we update a link to https-type link
            thumbnailPath = thumbnailPath.replacingOccurrences(of: "http", with: "https")
            thumbnailURL = URL(string: thumbnailPath)
        }
        var comicsList: [String] = []
        if let comics = character.comics?.items?.compactMap({ item in item.name }) {
            comicsList = comics
        }
        self.displayModel = CharacterDetailDisplayModel(name: character.name,
                                                        description: character.description,
                                                        thumbnailURL: thumbnailURL,
                                                        comics: comicsList)
    }
}
