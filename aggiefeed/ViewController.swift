//
//  ViewController.swift
//  aggiefeed
//
//  Created by Long H. Nguyen on 7/14/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activities = Activities()
        
        activities.fetchData(link: "https://aggiefeed.ucdavis.edu/api/v1/activity/public?s=0?l=25")
    }
}



