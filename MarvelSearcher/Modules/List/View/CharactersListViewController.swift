//
//  CharactersListViewController.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 04.03.2022.
//

import UIKit

/// View controller for displaing a characters list
final class CharactersListViewController: UIViewController {
    
    /// Sections for the table.
    enum Section: Hashable {
        case main
    }
    
    private var searchController = UISearchController(searchResultsController: nil)
    var tableView: UITableView = UITableView()
    private lazy var tableViewDataSource = createTableViewDataSource()
    
    let viewModel: CharactersListViewModelProtocol
        
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

	init(with model: CharactersListViewModelProtocol) {
		viewModel = model
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
        navigationItem.title = "\(EmojiHelper.prefix) Characters"
        loadNewData()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search characters"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.separatorStyle = .none
        let identifier = String(describing: CharacterTableViewCell.self)
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: identifier)
        view.applyFitConstraints(for: tableView)
        updateDiffableSnapshot()
    }
    
    private func updateDiffableSnapshot() {
        /// Craeate a snapshot for view model's data. Then updating a data source with a new data.
        var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterDisplayModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.displayModels, toSection: .main)
        tableViewDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func loadNewData() {
        Task {
            do {
                try await viewModel.loadNewData()
                updateDiffableSnapshot()
            } catch {
                catchError(with: "Unable to load a data from API.")
            }
        }
    }
    
    private func catchError(with text: String) {
        print(text)
    }
    
}

extension CharactersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        Task {
            do {
                try await viewModel.filter(with: searchController.searchBar.text)
                updateDiffableSnapshot()
            } catch {
                catchError(with: "Unable to load a data from API.")
            }
        }
    }
}

extension CharactersListViewController: TabBarItemAppearance {
    var tabBarItemTitle: String? { "Characters" }
    var tabBarItemIcon: UIImage? { UIImage(systemName: "person.3") }
}
