//
//  CreateAlertDetailViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/31/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CreateAlertDetailViewController: UIViewController {
    // TODO: Maybe when users click on the date/time label, it changes the date picker.
    
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToCreateAlertViewController(_ sender: UIStoryboardSegue) {
        if sender.source is TimePickerViewController {
            if let sourceView = sender.source as? TimePickerViewController {
                timeButton.setTitle(sourceView.dateSelected, for: .normal)
            }
        } else if sender.source is DatePickerViewController {
            if let sourceView = sender.source as? DatePickerViewController {
                dateButton.setTitle(sourceView.dateSelected, for: .normal)
            }
        }
    }
    
    @IBAction func timeButtonTapped(_ sender: UIButton) {
        // TODO: Instantiate the timePickerViewController and set the date the one in the timeButton
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "timePickerViewController") as! TimePickerViewController
        controller.dateSended = timeButton.titleLabel?.text
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func dateButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "datePickerViewController") as! DatePickerViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
