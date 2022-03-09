//
//  StartViewController.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 04.03.2022.
//

import UIKit

/// Protocol for determinating an appearance of tab bar items
protocol TabBarItemAppearance: AnyObject {
    
    /// Titile of view controller for tab bar item
    var tabBarItemTitle: String? { get }
    
    /// Icon of view controller for tab bar item
    var tabBarItemIcon: UIImage? { get }
}

/// Starting TabBar controller of the app
final class TabBarController: UITabBarController {
    
    private let listVC: CharactersListViewController
    
    init(listVC: CharactersListViewController) {
        self.listVC = listVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		let listNC = UINavigationController(rootViewController: listVC)
        listNC.tabBarItem.title = listVC.tabBarItemTitle
        listNC.tabBarItem.image = listVC.tabBarItemIcon
        viewControllers = [listNC]
        tabBar.backgroundColor = .systemBackground
    }
    
}
