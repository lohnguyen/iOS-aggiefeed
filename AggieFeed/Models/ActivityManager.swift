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
    
    func fetchData() {
        if let url = URL(string: K.link) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if var safeData = data {
                    safeData = self.parseHTMLEncoding(safeData)
                    self.delegate?.didFetchActivities(self, activities: self.parseJSON(safeData))
                }
            }
            
            task.resume()
        }
    }
    
    func parseHTMLEncoding(_ raw: Data) -> Data {
        var dataStr = String(data: raw, encoding: .utf8)!
        dataStr = String(htmlEncoding: dataStr)!
        return dataStr.data(using: .utf8)!
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


/*
* reference: parse HTML encoding characters
* https://stackoverflow.com/questions/25607247/how-do-i-decode-html-entities-in-swift
*/
extension String {
    init?(htmlEncoding: String) {
        guard let data = htmlEncoding.data(using: .utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else { return nil }

        self.init(attributedString.string)
    }
}

