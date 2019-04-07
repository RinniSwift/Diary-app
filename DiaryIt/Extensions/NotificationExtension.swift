//
//  NotificationExtension.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/30/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didExpand = Notification.Name("didExpand")
    static let didDeleteNotif = Notification.Name("didDeleteNotif")
    static let didAddTime = Notification.Name("didAddTime")
    static let didAddDate = Notification.Name("didAddDate")
}
