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


protocol SearchBoxActions: AnyObject {
    func showResults(query: String)
    func showMainPage()
}

class MovieListViewController: UIViewController {
    let searchView = UIView()
    let scrollView = UIScrollView()
    var stackView = UIStackView()
    let mainPageScrollView = UIScrollView()
    let mainPageStackView = UIStackView()
    var resultsViewSetup = false
    let movieCollectionPopular = CategoryGroupView(group: .popular)
    let movieCollectionFreeToWatch = CategoryGroupView(group: .freeToWatch)
    let movieCollectionTending = CategoryGroupView(group: .trending)
    let padding = 20
    lazy var searchBar: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.delegate = self
        return searchBarView
    }()
    
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
        addResultsViews()
        setResultsLayout()
        removeResultsView()
        loadMainPage()
        setMainLayout()
    }
    
    func loadSearchResults(query: String) {
        for movie in Movies.all() {
            if movie.title.lowercased().contains(query.lowercased()) {
                let cardView = MovieCardView(movie: movie)
                stackView.addArrangedSubview(cardView)
            }
        }
    }
    
    func setResultsLayout() {
        scrollView.snp.makeConstraints{ (make) in
            make.top.equalTo(searchView.snp.bottom).offset(padding)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalToSuperview()
        }
        
        stackView.axis = .vertical
        
        stackView.snp.makeConstraints{ (make) in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func addResultsViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
    }
    
    
    func loadMainPage() {
        
        view.addSubview(mainPageScrollView)
        mainPageScrollView.addSubview(mainPageStackView)
        mainPageStackView.axis = .vertical
        mainPageStackView.alignment = .leading
        mainPageStackView.distribution = .equalSpacing
        mainPageStackView.spacing = 20
        mainPageStackView.addArrangedSubview(movieCollectionPopular)
        mainPageStackView.addArrangedSubview(movieCollectionFreeToWatch)
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
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        } })
        
    }
    
    func showMainView() {
        mainPageScrollView.isHidden = false
        
    }
    
    
    func removeMainView() {
        mainPageScrollView.isHidden = true
        
    }
    
    func removeResultsView() {
        scrollView.isHidden = true

    }
    
    func showResultView() {
        scrollView.isHidden = false
        stackView.isHidden = false
    }
}


extension MovieListViewController: SearchBoxActions {
    func showMainPage() {
        removeResultsView()
        showMainView()
        resultsViewSetup = false

    }
    
    func showResults(query: String) {
        if !resultsViewSetup {
            resultsViewSetup = true
            removeMainView()
            showResultView()
        } else {
            stackView.subviews.forEach({ $0.removeFromSuperview() })
        }
        
        loadSearchResults(query: query)
    }
}
