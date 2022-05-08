//
//  NetworkServiceProtocolImplementation.swift
//  MovieApp
//
//  Created by Five on 07.05.2022..
//

import Foundation

class NetworkServiceProtocolImplementation: NetworkServiceProtocol {
    func getDataFromURL(requestUrl: String) {
        
        guard let url = URL(string: requestUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let networkService = NetworkService()

        networkService.executeUrlRequest(request) { stringValue, error in
            
            if error == nil {
                return
            }
            
            
            guard let value = stringValue else {
                return
            }
            
        
            print(value)
            
        }
        
            

    }
}
