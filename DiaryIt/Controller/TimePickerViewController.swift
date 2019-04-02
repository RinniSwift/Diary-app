//
//  TimePickerViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 4/1/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {
    // TODO: Create unwind segue to move data back to
    
    // MARK: - Variables
    var dateSelected: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
}
