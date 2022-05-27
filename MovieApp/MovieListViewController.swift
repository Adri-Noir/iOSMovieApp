//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Five on 09.04.2022..
//

import Foundation
import SnapKit
import UIKit
import MovieAppData
import Network


protocol SearchBoxActions: AnyObject {
    func userTyped(textBoxText: String)
    func userClearedText()
    func userPressedCancel()
}


protocol MovieCollectionViewActions: AnyObject {
    func userClickedMovie(movie: TMDBCategoryMovieModel)
}


class MovieListViewController: UIViewController {
    let searchView = UIView()
    let scrollView = UIScrollView()
    var stackView = UIStackView()
    let mainPageScrollView = UIScrollView()
    let mainPageStackView = UIStackView()
    lazy var searchResultsCollectionView : SearchResultsCollectionView = {
        let searchResultsCollectionView = SearchResultsCollectionView()
        searchResultsCollectionView.movieDelegate = self
        
        return searchResultsCollectionView
    }()
    
    var resultsViewSetup = false
    
    lazy var movieCollectionPopular : CategoryGroupView = {
        let movieCollectionPopular = CategoryGroupView(group: .popular)
        movieCollectionPopular.movieDelegate = self
        return movieCollectionPopular
    }()
    
    lazy var movieCollectionTopRated : CategoryGroupView = {
        let movieCollectionTopRated = CategoryGroupView(group: .topRated)
        movieCollectionTopRated.movieDelegate = self
        return movieCollectionTopRated
    }()
    
    lazy var movieCollectionTending : CategoryGroupView = {
        let movieCollectionTending = CategoryGroupView(group: .trending)
        movieCollectionTending.movieDelegate = self
        return movieCollectionTending
    }()
    
    let padding = 20
    lazy var searchBar: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.delegate = self
        return searchBarView
    }()
    var searchBackup : [TMDBCategoryMovieModel] = []
    
    
    override func viewDidLoad() {
        
        view.addSubview(searchView)
        searchView.addSubview(searchBar)
        view.backgroundColor = .white
        searchView.backgroundColor = .white
        
        searchView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding - 5)
            make.leading.equalToSuperview().offset(padding);
            make.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(60)
        }
        
        searchBar.snp.makeConstraints{ (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        
        setupResultsView()
        loadMainPage()
        setMainLayout()
        
        
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
    
    
    func setupResultsView() {
        addResultsViews()
        setResultsLayout()
        hideResultsView()
    }
    
    
    func loadSearchResults(query: String) {
        searchResultsCollectionView.search(query: query)
    }
    
    func setResultsLayout() {
        searchResultsCollectionView.snp.makeConstraints{ (make) in
            make.top.equalTo(searchView.snp.bottom).offset(padding)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalToSuperview()
        }

    }
    
    func addResultsViews() {
        view.addSubview(searchResultsCollectionView)
    }
    
    
    func loadMainPage() {
        
        view.addSubview(mainPageScrollView)
        mainPageScrollView.addSubview(mainPageStackView)
        mainPageStackView.axis = .vertical
        mainPageStackView.alignment = .leading
        mainPageStackView.distribution = .equalSpacing
        mainPageStackView.spacing = 20
        mainPageStackView.addArrangedSubview(movieCollectionPopular)
        mainPageStackView.addArrangedSubview(movieCollectionTopRated)
        mainPageStackView.addArrangedSubview(movieCollectionTending)
        
    }
    
    func setMainLayout() {
        mainPageScrollView.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
        
        mainPageStackView.snp.makeConstraints{ (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        mainPageStackView.arrangedSubviews.forEach({ $0.snp.makeConstraints{ (make) in
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
        } })
        
    }
    
    func showMainView() {
        mainPageScrollView.isHidden = false
        
    }
    
    
    func hideMainView() {
        mainPageScrollView.isHidden = true
        
    }
    
    func hideResultsView() {
        searchResultsCollectionView.isHidden = true

    }
    
    func showResultView() {
        searchResultsCollectionView.isHidden = false

    }
    
    func showResults(query: String) {
        if !resultsViewSetup {
            resultsViewSetup = true
            hideMainView()
            showResultView()
        } else {
            stackView.subviews.forEach({ $0.removeFromSuperview() })
        }
        
        loadSearchResults(query: query)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.searchResultsCollectionView.screenRotated()
        }, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.searchResultsCollectionView.screenRotated() // There is a weird issues I wasn't able to fix: when I click back on the navbar after I clicked on a movie everything in search results collection view resets

    }
    
}


extension MovieListViewController: SearchBoxActions {
    func userPressedCancel() {
        hideResultsView()
        showMainView()
        resultsViewSetup = false

    }
    
    func userTyped(textBoxText: String) {
        showResults(query: textBoxText.lowercased())
        
    }
    
    func userClearedText() {
        showResults(query: "")
    }
}


extension MovieListViewController: MovieCollectionViewActions {
    func userClickedMovie(movie: TMDBCategoryMovieModel) {
        searchBackup = searchResultsCollectionView.searchResults
        let appViewController = MovieDetailsViewController(movie: movie)
        self.navigationController?.pushViewController(appViewController, animated: true)
    }
}
