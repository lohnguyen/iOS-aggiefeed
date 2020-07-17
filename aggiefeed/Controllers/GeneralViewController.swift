//
//  ViewController.swift
//  aggiefeed
//
//  Created by Long H. Nguyen on 7/14/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class GeneralViewController: UIViewController {
    @IBOutlet weak var activityTable: UITableView!
    
    var activities: [Activity] = []
    var activityManager = ActivityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityTable.dataSource = self
        activityTable.delegate = self
        activityManager.delegate = self
        
        activityManager.fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let cell = sender as! ActivityCell
            let destVC = segue.destination as! DetailViewController
            destVC.activity = activities[cell.rowNum]
        }
    }
}

extension GeneralViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        
        cell.textLabel!.text = activities[indexPath.row].title
        cell.detailTextLabel!.text = activities[indexPath.row].actor.displayName
        cell.rowNum = indexPath.row
        
        return cell
    }
}

extension GeneralViewController: ActivityManagerDelegate {
    func didFetchActivities(_ activityManager: ActivityManager, activities: [Activity]) {
        self.activities = activities
        DispatchQueue.main.async { // reload cells after data is loaded
            self.activityTable.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
