//
//  MovieData+CoreDataProperties.swift
//  MovieApp
//
//  Created by Five on 29.05.2022..
//
//

import Foundation
import CoreData


extension MovieData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        return NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdrop_path: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var id: Int64
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var vote_average: Double
    @NSManaged public var vote_count: Int64
    @NSManaged public var genre_ids: NSSet?
    @NSManaged public var movie_group: NSSet?

}

// MARK: Generated accessors for genre_ids
extension MovieData {

    @objc(addGenre_idsObject:)
    @NSManaged public func addToGenre_ids(_ value: MovieGenreData)

    @objc(removeGenre_idsObject:)
    @NSManaged public func removeFromGenre_ids(_ value: MovieGenreData)

    @objc(addGenre_ids:)
    @NSManaged public func addToGenre_ids(_ values: NSSet)

    @objc(removeGenre_ids:)
    @NSManaged public func removeFromGenre_ids(_ values: NSSet)

}

// MARK: Generated accessors for movie_group
extension MovieData {

    @objc(addMovie_groupObject:)
    @NSManaged public func addToMovie_group(_ value: MovieGroupData)

    @objc(removeMovie_groupObject:)
    @NSManaged public func removeFromMovie_group(_ value: MovieGroupData)

    @objc(addMovie_group:)
    @NSManaged public func addToMovie_group(_ values: NSSet)

    @objc(removeMovie_group:)
    @NSManaged public func removeFromMovie_group(_ values: NSSet)

}

extension MovieData : Identifiable {

}
