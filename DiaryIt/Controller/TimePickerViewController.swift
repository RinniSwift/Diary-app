//
//  TimePickerViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 4/1/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {
    
    // MARK: - Variables
    var dateSelected: String = ""   // maybe not useful to store it as the string since we already send over the time as dateComponents
    var savedDateComponent: DateComponents? = nil
    
    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePickerDate(dateLabelString: dateSelected)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        NotificationCenter.default.post(name: .didAddTime, object: components)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateValueChanged(_ sender: Any) {
        dateSelected = datePicker.date.toHourMinute()
    }
    
    func setDatePickerDate(dateLabelString: String) {
        // setting string from datePicker to store in dateSelected var. to send to CreateAlertViewController
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let droppedString = String(dateLabelString.dropLast(3))
        let date = dateFormatter.date(from: droppedString)
        
        datePicker.date = date!
        dateSelected = dateLabelString
    }
}
