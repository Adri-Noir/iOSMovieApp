//
//  TMDBCategoryModel.swift
//  MovieApp
//
//  Created by Five on 07.05.2022..
//

import Foundation


struct TMDBCategoryModel : Codable {
    let page : Int
    let results : [TMDBCategoryMovieModel]
    let totalPages : Int
    let totalResults : Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}


struct TMDBCategoryMovieModel : Codable {
    let adult : Bool
    let backdropPath : String?
    let genreIds : [Int]
    let id : Int
    let originalLanguage : String
    let originalTitle : String
    let overview : String
    let popularity : Double
    let posterPath : String?
    let releaseDate : String
    let title : String
    let voteAverage : Double
    let voteCount : Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
