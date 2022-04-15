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

class MovieCollectionView: UIView {
    let cellIdentifier = "cellId"
    let collectionView : UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    
    var moviesList : [MovieModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(group : MovieGroup) {
        self.init(frame: CGRect.zero)

        populateMovieData(group: group)
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
    }

    func populateMovieData(group : MovieGroup) {
        for movie in Movies.all() {
            if (movie.group.contains(group)) {
                moviesList.append(movie)
            }
            
        }
    }
}

extension MovieCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath) as! MovieCell
        
        let movie = moviesList[indexPath.row]
        cell.setup(movie: movie)
        
        return cell
    }
}


extension MovieCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 225)
    }
}

