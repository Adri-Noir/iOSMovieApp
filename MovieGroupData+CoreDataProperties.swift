//
//  MovieGroupData+CoreDataProperties.swift
//  MovieApp
//
//  Created by Five on 29.05.2022..
//
//

import Foundation
import CoreData


extension MovieGroupData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGroupData> {
        return NSFetchRequest<MovieGroupData>(entityName: "MovieGroupData")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension MovieGroupData {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieData)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieData)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension MovieGroupData : Identifiable {

}
