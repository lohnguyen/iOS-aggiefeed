//
//  DetailViewController.swift
//  aggiefeed
//
//  Created by Long H. Nguyen on 7/16/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var activity: Activity!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (activity != nil) {
            print(activity!.title)
        }
    }

}
