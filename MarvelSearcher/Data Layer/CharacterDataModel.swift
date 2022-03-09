//
//  CharacterDataModel.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 21.02.2022.
//

import Foundation

struct CharacterDataModel: Codable {
    let id: Int
    let name: String
    let description: String?
    let thumbnail: ImageModel?
    let comics: ListModel?
    let stories: ListModel?
    let events: ListModel?
    let series: ListModel?
}

struct ImageModel: Codable {
    let path: String
    let fileExtension: String
    
    var fullPath: String { "\(path).\(fileExtension)" }
    
    private enum CodingKeys : String, CodingKey {
        case path, fileExtension = "extension"
    }
}

struct ListModel: Codable {
    let items: [SummaryModel]?
}

struct SummaryModel: Codable {
    let name: String?
}
