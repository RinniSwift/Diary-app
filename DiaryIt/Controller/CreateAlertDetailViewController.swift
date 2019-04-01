//
//  CreateAlertDetailViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/31/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CreateAlertDetailViewController: UIViewController {
    // TODO: create two date pickers for -date and -time
    // TODO: Maybe when users click on the date/time label, it changes the date picker.
    

    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        timeLabel.text = datePicker.date.toHourMinute()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = datePicker.date.toHourMinute()
    }

}
