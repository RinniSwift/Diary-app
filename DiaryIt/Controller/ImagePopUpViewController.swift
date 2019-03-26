//
//  ImagePopUpViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/24/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class ImagePopUpViewController: UIViewController, UIScrollViewDelegate {
    // TODO: when tapped on view, dismiss the view controller
    
    // MARK: - Variables
    var imageToFill: UIImage? = nil
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = imageToFill
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first?.location(in: view)
        
        if (touch?.y)! > (view.frame.height - 60) || (touch?.y)! < CGFloat(15)/*doesnt work*/{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
