//
//  ViewController.swift
//  aggiefeed
//
//  Created by Long H. Nguyen on 7/14/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class GeneralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activityTable: UITableView!
    
    var activities: [Activity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityTable.dataSource = self
        activityTable.delegate = self
        
        fetchData(link: "https://aggiefeed.ucdavis.edu/api/v1/activity/public?s=0?l=25")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        cell.textLabel!.text = activities[indexPath.row].title
        cell.detailTextLabel!.text = activities[indexPath.row].actor.displayName

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
//            let cell = sender as! UITableViewCell
            print("hellow")
            let destVC = segue.destination as! DetailViewController
            destVC.activity = activities[0]
        }
    }
    
    func fetchData(link: String) {
        if let url = URL(string: link) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.activities = self.parseJSON(safeData)
                    DispatchQueue.main.async { // reload cells after data is loaded
                        self.activityTable.reloadData()
                    }
                }
            }
            
            task.resume()
        }
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
            print(error)
        }
        
        return []
    }
    
}
