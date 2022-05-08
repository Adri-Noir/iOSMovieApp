//
//  NetworkService.swift
//  MovieApp
//
//  Created by Five on 05.05.2022..
//

import Foundation


class NetworkService {
    
    enum RequestError: Error {
        case clientError
        case serverError
        case noData
        case dataDecodingError
        case noDataError
        case decodingError
    }
    
    func executeUrlRequest(_ request: URLRequest, completionHandler: @escaping (Data?, RequestError?) -> Void) {

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
                completionHandler(data , nil)
            }

        }
        dataTask.resume()
    }
}
