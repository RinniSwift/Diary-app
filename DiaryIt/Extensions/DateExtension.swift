//
//  Extension.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/20/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

extension Date{
    
    func toString() -> String{  // "31 March"
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy MMMM dd"
        
        let myString = formatter.string(from: self) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd MMMM"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
    
    func toHourMinute() -> String { // "03.30 PM"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        
        let string = formatter.string(from: self)
        return string
    }
}
