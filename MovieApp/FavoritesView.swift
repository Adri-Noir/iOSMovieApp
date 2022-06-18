//
//  FavoritesView.swift
//  MovieApp
//
//  Created by Five on 29.05.2022..
//

import Foundation
import UIKit
import SnapKit


class FavoritesView: UIView {
    let cellIdentifier = "cellId"
    let collectionView : UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        flowlayout.minimumInteritemSpacing = 7
        flowlayout.minimumLineSpacing = 30
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    
    var favoriteMovies : [MovieData] = []
    weak var movieDelegate: CollectionViewActions?
    
    
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
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        collectionView.collectionViewLayout.invalidateLayout()
        
    }
    

    func fetchData(movies: [MovieData]) {
        favoriteMovies = movies
        collectionView.reloadData()
    }
}


extension FavoritesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath) as! MovieCell
        
        cell.movieDelegate = self
        
        let movie = favoriteMovies[indexPath.row]
        cell.setup(movie: movie)
        
        return cell
    }
}


extension FavoritesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 155)
    }
}

extension FavoritesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieDelegate?.movieClicked(movie: favoriteMovies[indexPath.row])
    }
}


extension FavoritesView: MovieCellDelegate {
    func userClickedLike(movie: MovieData) {
        for (index, favoriteMovie) in favoriteMovies.enumerated() {
            if favoriteMovie == movie {
                favoriteMovies.remove(at: index)
                collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
            }
        }
        
        movieDelegate?.movieLiked(movie: movie)
    }
}
