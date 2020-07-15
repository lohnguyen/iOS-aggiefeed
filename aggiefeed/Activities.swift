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
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(data: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        
        do {
            /*
             * reference: parse JSON as an array
             * https://stackoverflow.com/questions/48023096/swift-jsondecoder-typemismatch-error
             */
            let json = try decoder.decode([ActivityJSON].self, from: data)
            print(json.count)
        } catch {
            print(error)
        }
    }
}
