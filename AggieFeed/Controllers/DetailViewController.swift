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
        
    @IBOutlet weak var activityTitle: UILabel!
    @IBOutlet weak var actorDisplayName: UILabel!
    @IBOutlet weak var objectType: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = 8        
        
        if (activity != nil) {
            activityTitle.text = activity.title
            actorDisplayName.text = activity.actor.displayName
            objectType.text = activity.object.objectType
            publishedDate.text = activity.published
        }
    }

}
