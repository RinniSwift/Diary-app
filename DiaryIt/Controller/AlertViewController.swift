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
        
        // TEST:
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            let this = CoreDataHelper.retrieveNote().filter{ $0.date == "30 March"}.first
            print(this?.notifications)
            for notif in (this?.notifications)! {
                let notif = notif as! NotificationEntity
                print(notif.title)
            }
            
            print("reminders: \(NotificationCenterHelper.reminders.count)")
        })
        
    }
    
    // MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandingListeners()
        tableView.delegate = self
        tableView.dataSource = self
        // TODO: populate the table view with all retrieved notifications
    }
    
    func expandingListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(didExpand(_:)), name: .didExpand, object: nil)
    }
    
    @objc func didExpand(_ notification: Notification) {
        print("notification POSTED: expanding")
        // TODO: reload table view controller
    }
    
    func getAllNotifications() -> [NotificationEntity] {
        return CoreDataHelper.retrieveNotifications()
    }
}

extension AlertViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertCell") as! AlertTableViewCell
        return cell
    }
    
}

extension AlertViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


