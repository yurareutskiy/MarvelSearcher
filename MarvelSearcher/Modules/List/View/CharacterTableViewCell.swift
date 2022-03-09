//
//  CharacterTableViewCell.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 04.03.2022.
//

import UIKit

/// Cell for displaying a character in the list
final class CharacterTableViewCell: UITableViewCell {
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20.0)
        label.textColor = .darkText
        
        return label
    }()
    
    private var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.0
        view.clipsToBounds = true
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    var character: CharacterDisplayModel? {
        didSet {
            label.text = character?.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        
        /// Setup container view
        contentView.applyConstraints(for: container, top: 8.0, left: 16.0, right: -16.0, bottom: -8)
        
        /// Setup label
        container.applyConstraints(for: label, top: 0, left: 12.0, right: -8.0, bottom: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
