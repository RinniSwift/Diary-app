//
//  CreateAlertDetailViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/31/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CreateAlertDetailViewController: UIViewController {

    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
