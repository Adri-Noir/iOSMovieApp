//
//  MoviesDatabaseDataSource.swift
//  MovieApp
//
//  Created by Five on 27.05.2022..
//

import Foundation
import UIKit
import CoreData

class MoviesDatabaseDataSource {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func fetchAllMovies() -> [MovieData] {
        do {
            let results = try context.fetch(MovieData.fetchRequest())
            return results
        } catch {
            return []
        }
    }
    
    
    func fetchGenreData() -> [MovieGenreData] {
        do {
            let genres = try context.fetch(MovieGenreData.fetchRequest())
            return genres
        } catch {
            return []
        }
    }
    
    func addGenreData(networkGenreData data: [GenreModel]) {
        for genreData in data {
            let newGenre = MovieGenreData(context: context)
            newGenre.id = Int64(genreData.id)
            newGenre.name = genreData.name
            
            do {
                try context.save()
            } catch {
                continue
            }
        }
    }
    
    func updateGenreData(genreData: MovieGenreData, id: Int64, name: String) {
        genreData.id = id
        genreData.name = name
        do {
            try context.save()
            return
        } catch {
            return
        }
    }
    
    func deleteGenreData(genreData: MovieGenreData) {
        context.delete(genreData)
        
        do {
            try context.save()
            return
        } catch {
            return
        }
    }
    
    
    func addGroupData() {
        for group in Constants.movieGroups {
            let newGroup = MovieGroupData(context: context)
            newGroup.id = Int64(group.id)
            newGroup.name = group.name

            do {
                try context.save()
            } catch {
                continue
            }
        }
    }
    
    func fetchGroupMoviesData(group: String) -> [MovieData] {
        do {
            let request = MovieGroupData.fetchRequest() as NSFetchRequest<MovieGroupData>
            request.predicate = NSPredicate(format: "name LIKE %@", group)
            
            guard let result = try context.fetch(request).first else {return []}
            return result.movies?.allObjects as? [MovieData] ?? []
        } catch {
            return []
        }
    }
    
    func deleteGroupData(group: String) {
        do {
            let request = MovieGroupData.fetchRequest() as NSFetchRequest<MovieGroupData>
            request.predicate = NSPredicate(format: "name LIKE %@", group)
            
            guard let result = try context.fetch(request).first else {return}
            
            
            guard let movies = result.movies?.allObjects as? [MovieData] else {return}
            for movie in movies {
                result.removeFromMovies(movie)
            }
            
            try context.save()
        } catch {
            return
        }
    }
    
    func fetchMovieById(id: Int) -> MovieData? {
        do {
            let request = MovieData.fetchRequest() as NSFetchRequest<MovieData>
            request.predicate = NSPredicate(format: "id = %@", NSNumber(integerLiteral: id))
            
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    private func editMovie(databaseMovie: MovieData, movie: TMDBCategoryMovieModel) {
        databaseMovie.id = Int64(movie.id)
        databaseMovie.adult = movie.adult
        databaseMovie.backdrop_path = movie.backdropPath
        databaseMovie.original_title = movie.originalTitle
        databaseMovie.original_language = movie.originalLanguage
        databaseMovie.overview = movie.overview
        databaseMovie.popularity = movie.popularity
        databaseMovie.poster_path = movie.posterPath
        databaseMovie.release_date = movie.releaseDate
        databaseMovie.title = movie.title
        databaseMovie.video = movie.video
        databaseMovie.vote_average = movie.voteAverage
        databaseMovie.vote_count = Int64(movie.voteCount)
        
        for genreId in movie.genreIds {
            do {
                let request = MovieGenreData.fetchRequest() as NSFetchRequest<MovieGenreData>
                request.predicate = NSPredicate(format: "id = %@", NSNumber(integerLiteral: genreId))
                
                guard let result = try context.fetch(request).first else {continue}
                
                databaseMovie.addToGenre_ids(result)
            } catch {
                continue
            }
        }
        
    }
    
    private func addGroupToMovie(databaseMovie: MovieData, group: String) {
        do {
            let request = MovieGroupData.fetchRequest() as NSFetchRequest<MovieGroupData>
            request.predicate = NSPredicate(format: "name LIKE %@", group)
            
            guard let result = try context.fetch(request).first else {return}
            
            databaseMovie.addToMovie_group(result)
            
            return
            
        } catch {
            return
        }
    }
    
    
    func addMovie(movie: TMDBCategoryMovieModel, group: String, extraGenre: Int?) {
        let newMovie = MovieData(context: context)
        editMovie(databaseMovie: newMovie, movie: movie)
        if extraGenre != nil {
            addSingleGenreToMovie(movie: newMovie, genre: extraGenre!)
        }
        
        newMovie.favorite = false
        
        addGroupToMovie(databaseMovie: newMovie, group: group)
        
        
        do {
            try context.save()
        } catch {
            return
        }
    }
    
    
    func addSingleGroupToMovie(movie: MovieData, group: String) {
        addGroupToMovie(databaseMovie: movie, group: group)
        
        do {
            try context.save()
        } catch {
            return
        }
    }
    
    
    func addSingleGenreToMovie(movie: MovieData, genre: Int?) {
        if genre == nil {return}
        do {
            let request = MovieGenreData.fetchRequest() as NSFetchRequest<MovieGenreData>
            request.predicate = NSPredicate(format: "id = %@", NSNumber(integerLiteral: genre!))
            
            guard let result = try context.fetch(request).first else {return}
            
            movie.addToGenre_ids(result)
            
            
            try context.save()
            
        } catch {
            return
        }
    }
    
    
    func updateFavoritesField(movie: MovieData) {
        movie.favorite = !movie.favorite
        
        do {
            try context.save()
        } catch {
        }
        return
    }
    
    
    func fetchSearchResults(query: String) -> [MovieData] {
        do {
            let request = MovieData.fetchRequest() as NSFetchRequest<MovieData>
            request.predicate = NSPredicate(format: "title CONTAINS[c] %@", query)
            
            return try context.fetch(request)
            
        } catch {
            return []
        }
    }
    
    func fetchFavoriteMovies() -> [MovieData] {
        do {
            let request = MovieData.fetchRequest() as NSFetchRequest<MovieData>
            request.predicate = NSPredicate(format: "favorite = 1")
            
            return try context.fetch(request)
            
        } catch {
            return []
        }
    }

}
