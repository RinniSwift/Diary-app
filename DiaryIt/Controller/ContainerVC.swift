//
//  ContainerViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/25/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCalendarViewController()

    }
    
    func configureCalendarViewController() {
        let calendarController = ViewController()
        let controller = UINavigationController(rootViewController: calendarController)
        
        view.addSubview(controller.view)
        addChildViewController(controller)
        controller.didMove(toParentViewController: self)
    }
}
