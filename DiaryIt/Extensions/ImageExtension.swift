//
//  UIImageExtension.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/24/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resizeImage(view: UIView) -> UIImage {
        // TODO: Scale image into the textView to be smaller. Don't change the size of the image.
        
        let targetSize = CGSize(width: view.bounds.width - 40, height: view.frame.height / 3)
        let size = self.size
        
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / targetSize.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: (size.width * heightRatio), height: (size.height * heightRatio))
        } else {
            newSize = CGSize(width: (size.width * widthRatio), height: (size.height * widthRatio))
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
