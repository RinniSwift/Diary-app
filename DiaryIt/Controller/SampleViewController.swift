//
//  SampleViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/19/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit
import Photos

class SampleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textView: UITextView!
    
    // image variable
    let imagePicker = UIImagePickerController()
    
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        openPhotoLibrary()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.attributedText = NSAttributedString(string: "hello")
        imagePicker.delegate = self
        
    }
    
    func openPhotoLibrary() {
        PHPhotoLibrary.requestAuthorization{ (status) in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.imagePicker.sourceType = .photoLibrary
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            case .notDetermined:
                print("not determined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let resizeimage = resizeImage(image: image)
            addImageToString(image: resizeimage)
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    func resizeImage(image: UIImage) -> UIImage {
        let size = image.size
        let targetSize = CGSize(width: view.bounds.width - 30, height: view.frame.height / 2)
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: (size.width * heightRatio), height: (size.height * heightRatio))
        } else {
            newSize = CGSize(width: (size.width * widthRatio), height: (size.height * widthRatio))
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func addImageToString(image: UIImage) {
        let fullString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        let attachement = NSTextAttachment()
        attachement.image = image
                
        let imageToAttach = NSAttributedString(attachment: attachement)
        fullString.append(NSAttributedString(string: "\n"))
        fullString.append(imageToAttach)
        
        
        textView.attributedText = fullString
    }
}
