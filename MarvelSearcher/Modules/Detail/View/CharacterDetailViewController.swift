//
//  CharacterDetailViewController.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 04.03.2022.
//

import UIKit
import Kingfisher

/// Detailed view controller for a character
final class CharacterDetailViewController: UIViewController {
    
    private let viewModel: CharacterDetailViewModel
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .darkText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4.0
        return stackView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.displayModel.name
        view.backgroundColor = .systemBackground
        
        setupScrollView()
        setupContainerView()
        setupImageView()
        setupLabel()
        setupStackView()
    }
    
    private func setupScrollView() {
        view.applyFitConstraints(for: scrollView, ignoreSafeArea: false)
    }
    
    private func setupContainerView() {
        scrollView.applyConstraints(for: container, top: 8.0, left: 16.0, right: -16.0)
        NSLayoutConstraint.activate([
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: container.topAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    
    private func setupImageView() {
        container.applyConstraints(for: imageView, top: 12.0, left: 8.0, right: -8.0)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: container.widthAnchor, constant: -16.0),
            imageView.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -16.0)
        ])
        imageView.kf.setImage(with: viewModel.displayModel.thumbnailURL)
    }
    
    private func setupLabel() {
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.0)
        ])
        label.text = viewModel.displayModel.description
    }
    
    private func setupStackView() {
        container.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16.0),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8.0),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.0),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.0)
        ])
        if viewModel.displayModel.comics.isEmpty == false {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 16.0)
            label.textColor = .darkText
            label.text = "Comics:"
            stackView.addArrangedSubview(label)
        }
        for comic in viewModel.displayModel.comics {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14.0)
            label.textColor = .darkText
            label.text = comic
            stackView.addArrangedSubview(label)
        }
    }
}
