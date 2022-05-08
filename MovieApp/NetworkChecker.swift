//
//  NetworkChecker.swift
//  MovieApp
//
//  Created by Five on 07.05.2022..
//

import Foundation
import Network

class NetworkChecker {
    let monitor = NWPathMonitor()
    var connected = false
    let queue = DispatchQueue(label: "Monitor")
    
    
    func checkNetworkConnection() {
        
        monitor.pathUpdateHandler = { path in
           if path.status == .satisfied {
               self.connected = true
           } else {
               self.connected = false
           }
           print(path.isExpensive)
        }
        
        monitor.start(queue: queue)
    }
}
