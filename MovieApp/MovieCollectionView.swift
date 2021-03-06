//
//  MovieCollectionViewController.swift
//  MovieApp
//
//  Created by Five on 10.04.2022..
//

import Foundation
import SnapKit
import UIKit
import MovieAppData

protocol MovieCellDelegate: AnyObject {
    func userClickedLike(movie: MovieData)
}


class MovieCollectionView: UIView {
    let cellIdentifier = "cellId"
    let collectionView : UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    weak var movieDelegate: CollectionViewActions?
    
    
    var movies : [MovieData] = []
    var filteredMovies : [MovieData] = []
    var lastFilter : Int = 0

    
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
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
    }
    
    
    func setLayout() {
        
        collectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        collectionView.collectionViewLayout.invalidateLayout()
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }

    
    func filterMovies(filter: Int) {
        if lastFilter == filter {
            return
        }
        
        lastFilter = filter
        filteredMovies = []
        
        for movie in movies {
            for genre in movie.genre_ids?.allObjects as? [MovieGenreData] ?? [] {
                if genre.id == Int64(filter) {
                    filteredMovies.append(movie)
                }
            }
        }
        
        collectionView.reloadData()
        
        
    }
    
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension MovieCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath) as! MovieCell
        
        cell.movieDelegate = self
        
        let movie = filteredMovies[indexPath.row]
        cell.setup(movie: movie)
        
        return cell
    }
}


extension MovieCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 225)
    }
}


extension MovieCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieDelegate?.movieClicked(movie: filteredMovies[indexPath.row])
    }
}

extension MovieCollectionView: MovieCellDelegate {
    func userClickedLike(movie: MovieData) {
        movieDelegate?.movieLiked(movie: movie)
    }
}
