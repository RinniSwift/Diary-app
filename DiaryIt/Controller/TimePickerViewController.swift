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
    var dateSelected: String = ""
    var dateSended: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        if dateSended != nil {
            setDatePickerDate(dateLabelString: dateSended!)
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateValueChanged(_ sender: Any) {
        dateSelected = datePicker.date.toHourMinute()
    }
    
    func setDatePickerDate(dateLabelString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let droppedString = String(dateLabelString.dropLast(3))
        let date = dateFormatter.date(from: droppedString)
        
        datePicker.date = date!
        dateSelected = dateLabelString
    }
}
