//
//  NotificationCenterHelper.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/25/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationCenterHelper {
    
    class func addNotification() -> NotificationEntity {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Prepare for technical interviews"
        content.subtitle = "Reminding you to do this!"
        content.body = "Prepare for technical interviews after eating apples"
        content.sound = UNNotificationSound.default()
        
        let date = Date(timeIntervalSinceNow: 3)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        center.add(request) { err in
            if err != nil {
                print(err?.localizedDescription)
            }
        }
        return handleCoreData(notification: content, date: date)
        
    }
    
    class func removeNotification(date: String) -> [NotificationEntity] {
        var identifiers: [String] = []
        
        let allNotifications = CoreDataHelper.retrieveNotifications()
        var notificationAtDate = allNotifications.filter{ $0.date == date }
        
        for item in notificationAtDate {
            identifiers.append("content")
            CoreDataHelper.deleteNotification(notification: item)
        }

        let center = UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: identifiers)

        return allNotifications
    }
    
    
    class func handleCoreData(notification: UNMutableNotificationContent, date: Date) -> NotificationEntity {
        
        // create new notification to prepare for adding to array or storing as new array
        let notif = CoreDataHelper.newNotification(date: date.toString())
        notif.title = notification.title
        notif.subtitle = notification.subtitle
        notif.body = notification.body
        notif.date = date.toString()
        
        
        let firstNote = CoreDataHelper.retrieveNote().filter{$0.date == notif.date}.first
        
        // check if there are any notes saved at the date of when we will call the notification
        if firstNote == nil { // note saved at notification date is nil
            let note = CoreDataHelper.newNote()
            note.content = nil
            note.date = date.toString()
            note.notifications = NSSet(array: [notif])
        } else { // there're notes saved at the notification date
            if firstNote?.notifications == nil {
                firstNote?.notifications = NSSet(array: [notif])
            } else {
                var storedNotifs = Array((firstNote?.notifications)!)
                storedNotifs.append(notif)
                firstNote?.notifications = NSSet(array: storedNotifs)
            }
        }
        CoreDataHelper.saveNote()
        return notif
    }
}

