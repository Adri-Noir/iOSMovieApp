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
    weak var movieDelegate: CollectionViewActions?
    
    let apiKey = Constants.apiKey
    
    var moviesList : [MovieModel] = []
    
    var movies : [TMDBCategoryMovieModel] = []
    var filteredMovies : [TMDBCategoryMovieModel] = []
    var lastFilter : Int = 0
    var alreadyGotData = false
    var movieGroup : MovieGroup = .trending
    let pages = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(group : MovieGroup) {
        self.init(frame: CGRect.zero)
        self.movieGroup = group

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
        
        if (!alreadyGotData || movieGroup == .trending) {
            alreadyGotData = true
            
            NetworkService.fetchGroupData(movieGroup: movieGroup, trendingFilter: filter, pages: pages) {data, status in
                guard let data = data else {
                    self.collectionView.reloadData()
                    return
                }
                
                if self.movieGroup != .trending {
                    for movie in data.results {
                        self.movies.append(movie)
                    }
                    
                    if status == .finished {
                        for movie in self.movies {
                            if movie.genreIds.contains(filter) {
                                self.filteredMovies.append(movie)
                            }
                        }
                        self.collectionView.reloadData()
                    }
                    
                } else {
                    for movie in data.results {
                        self.filteredMovies.append(movie)
                    }
                    self.collectionView.reloadData()
                }
            }
        } else {
            for movie in movies {
                if movie.genreIds.contains(filter) {
                    filteredMovies.append(movie)
                }
            }
            self.collectionView.reloadData()
        }
        
        
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


//extension MovieCollectionView : NetworkServiceProtocol {
//    func getDataFromURL(requestUrl: String) {
//        guard let url = URL(string: requestUrl) else { return  }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let networkService = NetworkService()
//        networkService.executeUrlRequest(request) { dataValue, error in
//            if error != nil {
//                return
//            }
//            guard let value = dataValue else {
//                return
//            }
//
//
//            guard let value = try? JSONDecoder().decode(TMDBCategoryModel.self, from: value) else {
//                return
//            }
//
//            for movie in value.results {
//                self.movies.append(movie)
//            }
//            if self.lastFilter != -1 && self.lastFilter != -2 {
//                for movie in self.movies {
//                    if movie.genreIds.contains(self.lastFilter) {
//                        self.filteredMovies.append(movie)
//                    }
//                }
//            } else {
//                self.filteredMovies = self.movies
//            }
//
//
//            self.collectionView.reloadData()
//        }
//    }
//}
