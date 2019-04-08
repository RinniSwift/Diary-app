//
//  CreateAlertDetailViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/31/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CreateAlertDetailViewController: UIViewController {
    
    var timeDateCurrent: DateComponents? = nil  // sets value only when user clicks save on the timePickerViewController
    var dateDateCurrent: DateComponents? = nil  // sets value only when user clicks save on the datePickerViewController
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        guard titleTextField.text != "" && subtitleTextField.text != "" && bodyTextField.text != "" else {
            print("handle empty textFields")
            return
        }
        
        if timeDateCurrent == nil || dateDateCurrent == nil {
            let notif = NotificationCenterHelper.addNotificationWithTime(title: titleTextField.text!, subtitle: subtitleTextField.text!, body: bodyTextField.text!, date: Date(timeIntervalSinceNow: 3))
            NotificationCenter.default.post(name: .didAddReminderObject, object: notif)
        } else {
            var dateComponents = DateComponents()
            dateComponents.year = dateDateCurrent?.year
            dateComponents.month = dateDateCurrent?.month
            dateComponents.day = dateDateCurrent?.day
            dateComponents.hour = timeDateCurrent?.hour
            dateComponents.minute = timeDateCurrent?.minute
            let setDate = Calendar.current.date(from: dateComponents)
            
            let notif = NotificationCenterHelper.addNotificationWithTime(title: titleTextField.text!, subtitle: subtitleTextField.text!, body: bodyTextField.text!, date: setDate!)
            NotificationCenter.default.post(name: .didAddReminderObject, object: notif)
        }
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "timePickerViewController") as! TimePickerViewController
        controller.dateSelected = (timeButton.titleLabel?.text)!
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction func dateButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "datePickerViewController") as! DatePickerViewController
        controller.dateSelected = (dateButton.titleLabel?.text)!
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateInfoListeners()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    func dateInfoListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(addedTimeDateComponents(notification: )), name: .didAddTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addedDateDateComponents(notification: )), name: .didAddDate, object: nil)
    }

    @objc func addedTimeDateComponents(notification: Notification) {
        timeDateCurrent = (notification.object as! DateComponents)
    }
    
    @objc func addedDateDateComponents(notification: Notification) {
        dateDateCurrent = (notification.object as! DateComponents)
    }
}
