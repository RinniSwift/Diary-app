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

    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDatePickerDate(dateLabelString: dateSelected)
    }
    
    // MARK: - Actions
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        dateSelected = datePicker.date.toString()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // TODO: create compoments and send dateComponent object to createAlertViewCOntroller
        let components = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
        NotificationCenter.default.post(name: .didAddDate, object: components)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setDatePickerDate(dateLabelString: String) {
        // setting string from datePicker to store in dateSelected var. to send to CreateAlertViewController

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM yyyy"
        let date = dateFormatter.date(from: dateLabelString + " 2019")
        datePicker.date = date!
    }
}
