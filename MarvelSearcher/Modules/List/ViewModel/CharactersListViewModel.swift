//
//  CharactersListViewModel.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 04.03.2022.
//

import Foundation

/// Protocol for a view model of list of characters
protocol CharactersListViewModelProtocol: AnyObject {

    /// List of data models of characters (use them for the detailed screen)
    var characters: [CharacterDataModel] { get }
    
    /// List of display models of characters (use them for displaing a data on the view)
    var displayModels: [CharacterDisplayModel] { get }
    
    /// Returns a display model by index
	func displayModel(at index: Int) -> CharacterDisplayModel?
    
    /// Determine, is it reuired to load a new data based on current displayed index in the table
    func shouldLoadNewData(at index: Int) -> Bool
    
    /// Try to fetch a new data depending on current offset and insetring search text (if existed)
	func loadNewData() async throws
    
    /// Update a model with search text, trigger to fecth a list of superheroes based on the search text
	func filter(with text: String?) async throws
}

/// View model of list of characters
final class CharactersListViewModel: CharactersListViewModelProtocol {
    
    private(set) var characters: [CharacterDataModel] = []
    
    private(set) var displayModels: [CharacterDisplayModel] = []
    
    /// Offset paramter for API reuests
    private var offset = 0
    
    /// Search text for API requests
    private var searchText: String?
    
    /// Service for fetching a data about characters
    private let characterService: CharacterServiceProtocol
    
    /// Indicator whether the download is going or not
    private var isLoading = false

    /// Serial queue for updating a list of superheroes
    private let serialQueue = DispatchQueue(label: "MarvelAPI.SeialQueue.CharactersList")
        
    init(characterService: CharacterServiceProtocol) {
        self.characterService = characterService
    }
        
    func displayModel(at index: Int) -> CharacterDisplayModel? {
        guard characters.count > index else { return nil }
        let character = characters[index]
        let displayModel = CharacterDisplayModel(name: character.name)
        return displayModel
    }
    
    func loadNewData() async throws {
        guard isLoading == false else { return }
        isLoading = true
        let offset = self.offset
        let result = try await characterService.fetchCharacters(with: offset, search: searchText)
        serialQueue.sync {
            if offset == 0 {
                characters = []
            }
            self.offset = offset + result.count
            characters.append(contentsOf: result.results)
            displayModels = characters.map({ dataModel in
                CharacterDisplayModel(name: dataModel.name)
            })
        }
        isLoading = false
    }
    
    func filter(with text: String?) async throws {
        if let searchText = text, searchText.isEmpty == false {
            self.searchText = searchText
        } else {
            self.searchText = nil
        }
        offset = 0
        try await loadNewData()
    }
    
    func shouldLoadNewData(at index: Int) -> Bool {
        return index >= (offset - 1)
    }
}
