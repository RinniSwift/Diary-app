//
//  AlertViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/25/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit
import UserNotifications

class AlertViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions
    @IBAction func addReminder(_ sender: UIButton) {
        NotificationCenterHelper.addNotification()
    }
    
    // MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
