//
//  SearchResultsCollectionView.swift
//  MovieApp
//
//  Created by Five on 05.05.2022..
//


import Foundation
import SnapKit
import UIKit
import MovieAppData

class SearchResultsCollectionView: UIView {
    let cellIdentifier = "cellId"
    let collectionView : UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    weak var movieDelegate: MovieCollectionViewActions?

    var searchResults : [MovieData] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init() {
        self.init(frame: CGRect.zero)

        buildView()
        setLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    func buildView() {
        addSubview(collectionView)
        backgroundColor = .white
        
        collectionView.register(MovieCardView.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
    }
    
    
    func setLayout() {
        collectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        collectionView.collectionViewLayout.invalidateLayout()
        
    }

    func screenRotated() {
        collectionView.reloadData()
    }
    
    func search(movies: [MovieData]) {
        searchResults = movies
        
        collectionView.reloadData()
    }
}


extension SearchResultsCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath) as! MovieCardView
        
        let movie = searchResults[indexPath.row]
        cell.setup(movie: movie)
        
        return cell
    }
}


extension SearchResultsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: 209)
    }
}


extension SearchResultsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieDelegate?.userClickedMovie(movie: searchResults[indexPath.row])
    }
}

