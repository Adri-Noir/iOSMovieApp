//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Five on 04.05.2022..
//

import Foundation
import UIKit
import SnapKit

class FavoritesViewController: UIViewController {
    let moviesRepository = MoviesRepository()
    
    let titleLabel = UILabel()
    let favoritesView = UIView()
    lazy var favoritesCollectionView : FavoritesView = {
        let view = FavoritesView()
        view.movieDelegate = self
        return view
    }()
    
    override func viewDidLoad() {
        buildViews()
        setLayout()
        fillCollectionViewWithData()
    }
    
    
    func buildViews() {
        buildNavBar()
        view.backgroundColor = .white
        view.addSubview(favoritesView)
        favoritesView.addSubview(titleLabel)
        favoritesView.addSubview(favoritesCollectionView)
        titleLabel.text = "Favorites"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    
    func setLayout() {
        favoritesView.snp.makeConstraints {make in
            make.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
        
        titleLabel.snp.makeConstraints {make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
        }
        
        favoritesCollectionView.snp.makeConstraints {make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    func fillCollectionViewWithData() {
        favoritesCollectionView.fetchData(movies: moviesRepository.fetchAllFavoriteMovies())
    }
    
    func buildNavBar() {
        let navBar = UINavigationBarAppearance()
        navBar.configureWithDefaultBackground()
        navBar.backgroundColor = UIColor(red: 0.04, green: 0.15, blue: 0.25, alpha: 1.00)
        navigationItem.scrollEdgeAppearance = navBar
        navigationItem.standardAppearance = navBar
        navigationItem.compactAppearance = navBar
        
        self.navigationController?.navigationBar.tintColor = .white
        let titleView = UIView()
        let imageView = UIImageView(image: UIImage(named: "1a40d6f4d2d74d6370baae3e2adcfe1d"))
        imageView.contentMode = .scaleAspectFit
        titleView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        
        navigationItem.titleView = titleView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillCollectionViewWithData()
    }
}

extension FavoritesViewController: CollectionViewActions {
    func movieClicked(movie: MovieData) {
        let appViewController = MovieDetailsViewController(movie: movie)
        self.navigationController?.pushViewController(appViewController, animated: true)
    }
    
    func movieLiked(movie: MovieData) {
        moviesRepository.updateFavoritesField(movie: movie)
    }
}
