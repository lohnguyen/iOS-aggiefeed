//
//  ActivityManager.swift
//  aggiefeed
//
//  Created by Long H. Nguyen on 7/17/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import Foundation

protocol ActivityManagerDelegate {
    func didFetchActivities(_ activityManager: ActivityManager, activities: [Activity])
    func didFailWithError(_ error: Error)
}

struct ActivityManager {
    var delegate: ActivityManagerDelegate?
    let link = "https://aggiefeed.ucdavis.edu/api/v1/activity/public?s=0?l=25"
    
    func fetchData() {
        if let url = URL(string: link) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if var safeData = data {
                    safeData = self.parseApostrophe(safeData)
                    self.delegate?.didFetchActivities(self, activities: self.parseJSON(safeData))

                }
            }
            
            task.resume()
        }
    }
    
    func parseApostrophe(_ raw: Data) -> Data {
        let dataStr = String(data: raw, encoding: .utf8)?.replacingOccurrences(of: "&#8217;", with: "'")
        return dataStr!.data(using: .utf8)!
    }
    
    func parseJSON(_ data: Data) -> [Activity] {
        let decoder = JSONDecoder()
        
        do {
            /*
             * reference: parse JSON as an array
             * https://stackoverflow.com/questions/48023096/swift-jsondecoder-typemismatch-error
             */
            return try decoder.decode([Activity].self, from: data)
        } catch {
            self.delegate?.didFailWithError(error)
            return []
        }
    }
}
