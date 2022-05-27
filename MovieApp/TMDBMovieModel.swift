//
//  TMDBMovieModel.swift
//  MovieApp
//
//  Created by Five on 08.05.2022..
//

import Foundation


struct TMDBMovieModel : Codable {
    let adult : Bool
    let backdropPath : String
    let belongsToCollection : TMDBMovieCollection?
    let budget : Int
    let genres : [TMDBMovieGenres]
    let homepage : String?
    let id : Int
    let imdbId : String?
    let originalLanguage : String
    let originalTitle : String
    let overview : String
    let popularity : Double
    let posterPath : String
    let productionCompanies : [TMDBMovieProductionCompanies]
    let productionCountries : [TMDBMovieProductionCountries]
    let releaseDate : String
    let revenue: Int
    let runtime: Int
    let spokenLanguages : [TMDBMovieSpokenLanguages]
    let status : String
    let tagline : String
    let title : String
    let video : Bool
    let voteAverage : Double
    let voteCount : Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


struct TMDBMovieGenres : Codable {
    let id : Int
    let name : String
}


struct TMDBMovieCollection : Codable {
    let id : Int
    let name : String
    let posterPath : String?
    let backdropPath : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}



struct TMDBMovieProductionCompanies : Codable {
    let id : Int
    let logoPath : String?
    let name : String
    let originCountry : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}


struct TMDBMovieProductionCountries : Codable {
    let iso31661 : String
    let name : String
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
    
}


struct TMDBMovieSpokenLanguages : Codable {
    let englishName : String
    let iso6391 : String
    let name : String
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}
