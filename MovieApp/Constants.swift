//
//  Constants.swift
//  MovieApp
//
//  Created by Five on 20.05.2022..
//

import Foundation


struct Constants {
    static let apiKey = "5e135564283add29108f3c254b2a7bce"
    
    static let movieGroups = [GroupConstant(id: 1, name: "trending"), GroupConstant(id: 2, name: "popular"), GroupConstant(id: 3, name: "toprated")]
    
    static let resultsPages = 4
    
    static let trendingFilters : [GenreModel] = [GenreModel(id: -1, name: "Day"), GenreModel(id: -2, name: "Week")]
    
    static let popularUrlTemplate = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=%@&api_key="+Constants.apiKey

    static let topRatedUrlTemplate = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=%@&api_key="+Constants.apiKey
    
    static let trendingDayUrlTemplate = "https://api.themoviedb.org/3/trending/movie/day?api_key="+Constants.apiKey+"&page=%@"
    
    static let trendingWeekUrlTemplate = "https://api.themoviedb.org/3/trending/movie/week?api_key="+Constants.apiKey+"&page=%@"
}
