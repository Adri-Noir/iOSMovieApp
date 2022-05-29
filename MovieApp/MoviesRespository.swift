//
//  MovieRespository.swift
//  MovieApp
//
//  Created by Five on 27.05.2022..
//

import Foundation
import CoreData

class MoviesRepository {
    let moviesDatabaseDataSource = MoviesDatabaseDataSource()
    let moviesNetworkDataSource = MoviesNetworkDataSource()
    
    
    func fetchGenreData(completionHandler: @escaping ([GenreModel]) -> Void) {
        self.moviesDatabaseDataSource.addGenreData(networkGenreData: Constants.trendingFilters)
        let databaseGenreData = moviesDatabaseDataSource.fetchGenreData()
        completionHandler(databaseGenreData.map() {genreData in
            return GenreModel(id: Int(genreData.id), name: genreData.name ?? "")
        }.filter() {genreData in
            return genreData.id != -1 && genreData.id != -2
        })
        
        moviesNetworkDataSource.fetchNetworkGenreData() {data in
            guard let genreData = data else {return}

            self.moviesDatabaseDataSource.addGenreData(networkGenreData: genreData)

            completionHandler(genreData)
            
        }
    }
    
    func generateGroupData() {
        moviesDatabaseDataSource.addGroupData()
    }
    
    
    func fetchGroupData(group: String, completionHandler: @escaping ([MovieData]) -> Void) {
        completionHandler(moviesDatabaseDataSource.fetchGroupMoviesData(group: group))
    }
    
    
    private func fetchGroupMovieData(url: String, group: String, completionHandler: @escaping () -> Void) {
        moviesNetworkDataSource.fetchNetworkMoviesData(url: url) {resultData in
            if resultData.count == 0 {
                completionHandler()
                return
                
            }
            
            var extraGenre : Int? = nil
            if url.contains("day") {
                extraGenre = -1
            }
            
            if url.contains("week") {
                extraGenre = -2
            }
            
            for movie in resultData {
                
                
                guard let existingMovie = self.moviesDatabaseDataSource.fetchMovieById(id: movie.id) else {
                    self.moviesDatabaseDataSource.addMovie(movie: movie, group: group, extraGenre: extraGenre)
                    continue
                }
          
                self.moviesDatabaseDataSource.addSingleGroupToMovie(movie: existingMovie, group: group)
                self.moviesDatabaseDataSource.addSingleGenreToMovie(movie: existingMovie, genre: extraGenre)
                
            }
            completionHandler()
        }
    }
    
    
    func generateMovieData(completionHandler: @escaping () -> Void) {
        
        self.moviesDatabaseDataSource.deleteGroupData(group: "trending")
        self.moviesDatabaseDataSource.deleteGroupData(group: "popular")
        self.moviesDatabaseDataSource.deleteGroupData(group: "toprated")


        self.fetchGroupMovieData(url: Constants.trendingDayUrlTemplate, group: "trending") {}

        self.fetchGroupMovieData(url: Constants.trendingWeekUrlTemplate, group: "trending") {}
        
        self.fetchGroupMovieData(url: Constants.popularUrlTemplate, group: "popular") {}
        
        self.fetchGroupMovieData(url: Constants.topRatedUrlTemplate, group: "toprated") {
            completionHandler()
        }
        
    }
    
    func updateFavoritesField(movie: MovieData) {
        moviesDatabaseDataSource.updateFavoritesField(movie: movie)
    }
    
    func fetchSearchResults(query: String) -> [MovieData] {
        return moviesDatabaseDataSource.fetchSearchResults(query: query)
    }
    
    func fetchAllFavoriteMovies() -> [MovieData] {
        return moviesDatabaseDataSource.fetchFavoriteMovies()
    }
}
