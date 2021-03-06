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
        
    }
    
    // MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expandingListeners()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        allReminders = getAllNotifications()
        removeEarlierNotifications(date: Date())
    }
    
    func expandingListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(didExpand(_:)), name: .didExpand, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDeleteNotif(_:)), name: .didDeleteNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didAddReminderObject(_:)), name: .didAddReminderObject, object: nil)
    }
    
    @objc func didExpand(_ notification: Notification) {
    }
    
    @objc func didDeleteNotif(_ notification: Notification) {
        // TODO: When notification is shown.. do something
        let timeOfNotification = notification.object as! String
        allReminders = allReminders.filter{ $0.date != timeOfNotification}
        tableView.reloadData()
        
        for item in CoreDataHelper.retrieveNotifications().filter({$0.date == timeOfNotification}) {
            CoreDataHelper.deleteNotification(notification: item)
        }
    }
    
    @objc func didAddReminderObject(_ notification: Notification) {
        let reminderObj = notification.object as! NotificationEntity
        allReminders.append(reminderObj)
        tableView.reloadData()
    }
    
    func getAllNotifications() -> [NotificationEntity] {
        return CoreDataHelper.retrieveNotifications()
    }
    
    func removeEarlierNotifications(date: Date) {
        let allNotifs = CoreDataHelper.retrieveNotifications()
        // TODO: get date of notifications and remove the ones that are before the date.
        
        for notification in allNotifs {
            let dateValue = notification.date?.stringToDate()
            if date > dateValue! {  // date has passed
                CoreDataHelper.deleteNotification(notification: notification)
            }
        }
        tableView.reloadData()
    }
}


extension AlertViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allReminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertCell") as! AlertTableViewCell
        let reminderAtIndex = allReminders[indexPath.item]
        cell.alertTitleLabel.text = reminderAtIndex.title
        cell.alertDateLabel.text = reminderAtIndex.date // TODO: change 'toFullDateString' to 'toString' format
        return cell
    }
}

extension AlertViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}


