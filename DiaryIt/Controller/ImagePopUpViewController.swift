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
    var imagesInNote: [NSData] = []
    var imageIndex: Int = 0
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = imageToFill
        
        var swipeGestRecognizer = UISwipeGestureRecognizer(target: self, action: #selector (swiped(gesture:)))
        self.view.addGestureRecognizer(swipeGestRecognizer)
    }
    
    @objc func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            // TODO: switch case never falls in left direction
            switch swipeGesture.direction {
                
            case .right:
                print("User swiped right")
                
                // decrease index first
                
                imageIndex -= 1
                
                // check if index is in range
                
                if imageIndex < 0 {
                    
                    imageIndex = 1
                    
                }
                imageView.image = UIImage(data: imagesInNote[imageIndex] as Data)
            case UISwipeGestureRecognizerDirection.left:
                print("User swiped Left")
                
                // increase index first
                
                imageIndex += 1
                
                // check if index is in range
                
                if imageIndex > 1 {
                    
                    imageIndex = 0
                    
                }
            imageView.image = UIImage(data: imagesInNote[imageIndex] as Data)
            default:
                break //stops the code/codes nothing.
            }
            
        }
        
        
    }
    

}
