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
    
    // MARK: - Variables
    var allReminders: [NotificationEntity] = []
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
     
    // MARK: - Actions
    @IBAction func addReminder(_ sender: UIButton) {
        
        let addedNotif = NotificationCenterHelper.addNotification()
        allReminders.append(addedNotif)
        tableView.reloadData()
        
        // TEST:
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            let this = CoreDataHelper.retrieveNote().filter{ $0.date == "30 March"}.first
            print("TEST: All notifs after 1.5 seconds \(CoreDataHelper.retrieveNotifications().count)")
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
            let this = CoreDataHelper.retrieveNote().filter{ $0.date == "30 March"}.first
            print("TEST: All notifs after 6 seconds \(CoreDataHelper.retrieveNotifications().count)")
        })
    }
    
    // MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandingListeners()
        tableView.delegate = self
        tableView.dataSource = self
        
        guard getAllNotifications().count >= 1 else {
            tableView.reloadData()
            return
        }
        allReminders = getAllNotifications()
        
    }
    
    func expandingListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(didExpand(_:)), name: .didExpand, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDeleteNotif(_:)), name: .didDeleteNotif, object: [NotificationEntity].self)
    }
    
    @objc func didExpand(_ notification: Notification) {
        tableView.reloadData()
    }
    
    @objc func didDeleteNotif(_ notification: Notification) {
        allReminders = notification.object as! [NotificationEntity]
        tableView.reloadData()
    }
    
    func getAllNotifications() -> [NotificationEntity] {
        return CoreDataHelper.retrieveNotifications()
    }
}



extension AlertViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF ROWS: \(allReminders.count)")
        print("ITEM IN ROW: \(allReminders.first?.body)")
        return allReminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertCell") as! AlertTableViewCell
        let reminderAtIndex = allReminders[indexPath.item]
        cell.alertTitleLabel.text = reminderAtIndex.title
        cell.alertDateLabel.text = reminderAtIndex.date
        return cell
    }
    
}

extension AlertViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}


