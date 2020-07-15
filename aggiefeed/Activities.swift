//
//  Activities.swift
//  aggiefeed
//
//  Created by Long H. Nguyen on 7/15/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import Foundation

struct Activities {
    func fetchData(link: String) {
        if let url = URL(string: link) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handleData(data:response:error:))
            
            task.resume()
        }
    }
    
    func handleData(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataStr = String(data: safeData, encoding: .utf8)
            print(dataStr!)
        }
    }
}

