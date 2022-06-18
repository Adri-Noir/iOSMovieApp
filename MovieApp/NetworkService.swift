//
//  NetworkService.swift
//  MovieApp
//
//  Created by Five on 05.05.2022..
//

import Foundation
import MovieAppData


class NetworkService {
    
    enum RequestError: Error {
        case clientError
        case serverError
        case noDataError
    }
    
    private static func executeUrlRequest(_ request: URLRequest, completionHandler: @escaping (Data?, RequestError?) -> Void) {

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(nil, .clientError)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(nil, .serverError)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, .noDataError)
                }
                return
            }

            DispatchQueue.main.async {
                completionHandler(data, nil)
            }

        }
        dataTask.resume()
    }
    
    private static func fetchRawData(requestUrl url: String, completionHandler: @escaping (Data?) -> Void) {
        guard let url = URL(string: url) else { return  }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        executeUrlRequest(request) { dataValue, error in
            if error != nil {
                completionHandler(nil)
                return
            }
            guard let value = dataValue else {
                completionHandler(nil)
                return
            }
            
            completionHandler(value)
        }
    }
    
    static func fetchMovieCast(movieId id: Int, completionHandler: @escaping (TMDBCreditsModel?) -> Void) {
        fetchRawData(requestUrl: "https://api.themoviedb.org/3/movie/"+String(id)+"/credits?api_key="+Constants.apiKey) {data in
            
            guard let data = data else {
                completionHandler(nil)
                return
            }
            
            guard let value = try? JSONDecoder().decode(TMDBCreditsModel.self, from: data) else {
                completionHandler(nil)
                return
            }
            
            completionHandler(value)
        }
    }
    
    static func fetchGenres(completionHandler: @escaping ([GenreModel]?) -> Void) {
        fetchRawData(requestUrl: "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key="+Constants.apiKey) {data in
            guard let data = data else {
                completionHandler(nil)
                return
            }
            
            guard let value = try? JSONDecoder().decode(TMDBGenresModel.self, from: data) else {
                completionHandler(nil)
                return
            }
            
            var genreList : [GenreModel] = []
            for row in value.genres {
                genreList.append(GenreModel(id: row.id, name: row.name))
            }
            
            completionHandler(genreList)
        }
    }
    
    static func fetchSinglePageOfGroupData(requestUrl url: String, completionHandler: @escaping (TMDBCategoryModel?) -> Void) {
        fetchRawData(requestUrl: url) {data in
            guard let data = data else {
                completionHandler(nil)
                return
            }
            
            guard let value = try? JSONDecoder().decode(TMDBCategoryModel.self, from: data) else {
                completionHandler(nil)
                return
            }
            
            completionHandler(value)
        }
    }
}
