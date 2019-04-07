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
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        center.add(request) { err in
            if err != nil {
                print(err?.localizedDescription as Any)
            }
        }
        
        return saveNotificationToCoreData(notification: content, date: date)
    }
    
    
    class func addNotificationWithTime(title: String, subtitle: String, body: String, date: Date) -> NotificationEntity {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let date = date
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        center.add(request) { err in
            if err != nil {
                print(err?.localizedDescription as Any)
            }
        }
            
        return saveNotificationToCoreData(notification: content, date: date)
    }
    
    
    
    class func saveNotificationToCoreData(notification: UNMutableNotificationContent, date: Date) -> NotificationEntity {
        
        // create new notification to prepare for adding to array or storing as new array
        let notif = CoreDataHelper.newNotification()
        notif.title = notification.title
        notif.subtitle = notification.subtitle
        notif.body = notification.body
        notif.date = date.toString()
        
        CoreDataHelper.saveNote()
        return notif
    }
}
