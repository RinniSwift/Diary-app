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
    
    class func addNotification() {
        let center = UNUserNotificationCenter.current()
        
        var content = UNMutableNotificationContent()
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
                print(err?.localizedDescription)
            }
        }
    }
    
}
