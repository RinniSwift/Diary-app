//
//  ImagePopUpViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/24/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class ImagePopUpViewController: UIViewController {
    // TODO: when tapped on view, dismiss the view controller
    
    var imageToFill: UIImage? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = imageToFill
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
