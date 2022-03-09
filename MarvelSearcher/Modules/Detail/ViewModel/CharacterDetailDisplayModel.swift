//
//  CharacterDetailDisplayModel.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 09.03.2022.
//

import Foundation

/// Display model for detailed view of a character
struct CharacterDetailDisplayModel {
    
    /// Character's name
    let name: String
    
    /// Character's description (optional)
    let description: String?
    
    /// Character's image (optional)
    let thumbnailURL: URL?
    
    /// List of comic names
    let comics: [String]
}
