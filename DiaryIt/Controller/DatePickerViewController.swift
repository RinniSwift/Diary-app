//
//  DatePickerViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 4/1/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    // MARK: - Variables
    var dateSelected: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setDatePickerDate(dateLabelString: dateSelected)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Actions
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        dateSelected = datePicker.date.toString()
    }
    
<<<<<<< HEAD
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
        NotificationCenter.default.post(name: .didAddDate, object: components)
    }
    
=======
>>>>>>> parent of 69eeb63... added NotificationCenter with 'post' method to send dateComponents of selected date to CreateAlertViewController
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setDatePickerDate(dateLabelString: String) {
        // TODO: create date formatter and set the date picker to equal the date(from: String) format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM yyyy"
        let date = dateFormatter.date(from: dateLabelString + " 2019")
        print(dateSelected)
        print(date)
        datePicker.date = date!
    }
}
