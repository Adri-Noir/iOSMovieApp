//
//  TabBarController.swift
//  MovieApp
//
//  Created by Five on 05.05.2022..
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    let movieListsViewController = MovieListViewController()
    let favoritesViewController = FavoritesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(red: 0.04, green: 0.15, blue: 0.25, alpha: 1.00)
    

        let navigationController = UINavigationController(rootViewController: movieListsViewController)
        
        let tabOne = UITabBarItem(
            title: "Home", image: UIImage(systemName: "house")!
                .withTintColor(UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1.00), renderingMode: .alwaysOriginal),
            
            selectedImage: UIImage(systemName: "house.fill")!
                .withTintColor(UIColor(red: 0.04, green: 0.15, blue: 0.25, alpha: 1.00), renderingMode: .alwaysOriginal))
        
        
        navigationController.tabBarItem = tabOne
        
        
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        let tabTwo = UITabBarItem(
            title: "Favorites", image: UIImage(systemName: "heart")!
                .withTintColor(UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1.00), renderingMode: .alwaysOriginal),
            
            selectedImage: UIImage(systemName: "heart.fill")!
                .withTintColor(UIColor(red: 0.04, green: 0.15, blue: 0.25, alpha: 1.00), renderingMode: .alwaysOriginal))
        
        favoritesViewController.tabBarItem = tabTwo
        
        self.viewControllers = [navigationController, favoritesNavigationController]
        
    }
}
