//
//  TMDBCreditsModel.swift
//  MovieApp
//
//  Created by Five on 08.05.2022..
//

import Foundation


struct TMDBCreditsModel : Codable {
    let id : Int
    let cast : [TMDBCastModel]
    let crew: [TMDBCrewModel]
}


struct TMDBCrewModel : Codable {
    let adult : Bool
    let gender : Int
    let id : Int
    let knownForDepartment : String
    let name : String
    let originalName : String
    let popularity : Double
    let profilePath : String?
    let creditId : String
    let department : String
    let job : String
    
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case creditId = "credit_id"
        case department
        case job
    }
}


struct TMDBCastModel : Codable {
    let adult : Bool
    let gender : Int
    let id : Int
    let knownForDepartment : String
    let name : String
    let originalName : String
    let popularity : Double
    let profilePath : String?
    let castId : Int
    let character : String
    let creditId : String
    let order : Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order
    }
}

