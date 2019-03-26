//
//  ContainerViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/25/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class ContainerViewC: UIViewController {
    
    var alertViewController: UIViewController!
    var centerViewController: UINavigationController!
    var isExpanded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStartViewController()
        
        
    }
    
    func configureStartViewController() {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewControllerID") as! ViewController
        homeVC.delegate = self
        centerViewController = UINavigationController(rootViewController: homeVC)
        centerViewController.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(centerViewController.view)
        addChildViewController(centerViewController)
        centerViewController.didMove(toParentViewController: self)
    }
    
    func configureRedViewController() {
        if alertViewController == nil {
            alertViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alertViewID") as! AlertViewController
            view.insertSubview(alertViewController.view, at: 0)
            addChildViewController(alertViewController)
            alertViewController.didMove(toParentViewController: self)
        }
    }
    
    func showRedViewController(shouldExpand: Bool) {
        
        if shouldExpand {
            // show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerViewController.view.frame.origin.x = self.centerViewController.view.frame.width - 80
                }, completion: nil)
        } else {
            // hide menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerViewController.view.frame.origin.x = 0
            }, completion: nil)
        }
        
    }
}



extension ContainerViewC: CalendarControllerDelegate {
    
    func handleSideToggle() {
        if !isExpanded {
            configureRedViewController()
        }
        isExpanded = !isExpanded
        showRedViewController(shouldExpand: isExpanded)
    }
    
}
