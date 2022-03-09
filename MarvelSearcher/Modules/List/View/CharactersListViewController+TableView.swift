//
//  CharactersListViewController+TableView.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 09.03.2022.
//

import UIKit

extension CharactersListViewController: UITableViewDelegate {
    
    func createTableViewDataSource() -> UITableViewDiffableDataSource<Section, CharacterDisplayModel> {
        let dataSource = UITableViewDiffableDataSource<Section, CharacterDisplayModel>(tableView: tableView) { [unowned self] tableView, indexPath, character in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTableViewCell.self)) as? CharacterTableViewCell else {
                return UITableViewCell()
            }
            cell.character = character
            if viewModel.shouldLoadNewData(at: indexPath.row) {
                loadNewData()
            }
            return cell
        }
        return dataSource
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = viewModel.characters[indexPath.row]
        let viewModel = CharacterDetailViewModel(character: character)
        let vc = CharacterDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
}
