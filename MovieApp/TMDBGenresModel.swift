//
//  TMDBGenreModel.swift
//  MovieApp
//
//  Created by Five on 08.05.2022..
//

import Foundation


struct TMDBGenresModel : Codable {
    let genres : [GenreModel]
}


struct GenreModel : Codable {
    let id : Int
    let name : String
}
