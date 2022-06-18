//
//  MovieGenreData+CoreDataProperties.swift
//  MovieApp
//
//  Created by Five on 29.05.2022..
//
//

import Foundation
import CoreData


extension MovieGenreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGenreData> {
        return NSFetchRequest<MovieGenreData>(entityName: "MovieGenreData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension MovieGenreData {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieData)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieData)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension MovieGenreData : Identifiable {

}
