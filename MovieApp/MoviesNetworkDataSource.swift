//
//  MoviesNetworkDataSource.swift
//  MovieApp
//
//  Created by Five on 27.05.2022..
//

import Foundation

class MoviesNetworkDataSource {
    
    func fetchNetworkGenreData(completionHandler: @escaping ([GenreModel]?) -> Void) {
        NetworkService.fetchGenres() {data in
            guard let genreData = data else {
                completionHandler(nil)
                return
            }
            
            completionHandler(genreData)
        }
    }
    
    
    func fetchNetworkMoviesData(url: String, completionHandler: @escaping ([TMDBCategoryMovieModel]) -> Void) {
        var results : [TMDBCategoryMovieModel] = []
        for page in 1...Constants.resultsPages {
            NetworkService.fetchSinglePageOfGroupData(requestUrl: String(format: url, String(page))) {data in
                guard let data = data else {
                    completionHandler([])
                    return
                }
                
                if data.totalResults == 0 {
                    completionHandler(results)
                    return
                }
                
                for result in data.results {
                    results.append(result)
                }
                
                if (page == Constants.resultsPages-1) {
                    completionHandler(results)
                }
                
            }
        }
        
    }
}
