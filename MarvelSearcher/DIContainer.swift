//
//  DIContainer.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 09.03.2022.
//

import UIKit
import Swinject

/// Dependency injection container for the app
final class DIContainer {
    
    /// Starting point of the app. Set it as a root controller to window.
    var startViewController: UIViewController? {
        container.resolve(TabBarController.self)
    }
    
    /// Regirering all dependencies
    private let container: Container = {
        let container = Container()
        container.register(AuthServiceProtocol.self) { _ in
            AuthService(apiKey: Secrets.MarvelAPI.apiKey, privateKey: Secrets.MarvelAPI.privateKey)
        }
        container.register(APIManagerProtocol.self) { di in
            APIManager(authService: di.resolve(AuthServiceProtocol.self))
        }
        container.register(CharacterServiceProtocol.self) { di in
            CharacterService(apiManager: di.resolve(APIManagerProtocol.self)!)
        }
        container.register(CharactersListViewModelProtocol.self) { di in
            CharactersListViewModel(characterService: di.resolve(CharacterServiceProtocol.self)!)
        }
        container.register(CharactersListViewController.self) { di in
            CharactersListViewController(with: di.resolve(CharactersListViewModelProtocol.self)!)
        }
        container.register(TabBarController.self) { di in
            TabBarController(listVC: di.resolve(CharactersListViewController.self)!)
        }
        return container
    }()
    
}
