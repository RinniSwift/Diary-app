//
//  DiaryMain.swift
//  DiaryIt
//
//  Created by Rinni Swift on 10/17/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit
import Photos

class DiaryMain: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    // TODO: set string variables to be set to the dateLabel and textView text
    
    // MARK: - Variables
    var date: Date!
    var imagePicker = UIImagePickerController()
    
    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Actions
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
//      TODO: NEW function that add image to textView
        openPhotoLibrary()
    }
    
    // MARK: - Photo Handling functions
    func openPhotoLibrary() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.imagePicker.sourceType = .photoLibrary
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            case .denied:
                print("denied")
            case .notDetermined:
                print("not determined")
            case .restricted:
                print("restricted")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
            print("image picked is nil")
            return
        }
        let resizedImage = resizeImage(image: image)
        addImageToString(image: resizedImage)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func addImageToString(image: UIImage) {
        // setting the attributes of the string
        let textAttributes: [NSAttributedStringKey: Any] = [
            .font: UIFont(name: "Avenir-Book", size: 17),
            .foregroundColor: UIColor(red:0.42, green:0.42, blue:0.42, alpha:1.0)]
        
        
        let fullString = NSMutableAttributedString(attributedString: textView.attributedText)
        fullString.setFont()
        
        let attachement = NSTextAttachment()
        attachement.image = image
        
        let imageToAttach = NSAttributedString(attachment: attachement)
        
        fullString.append(imageToAttach)
        fullString.append(NSAttributedString(string: "\n", attributes: textAttributes))
        
        textView.attributedText = fullString
        textView.reloadInputViews()
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        let targetSize = CGSize(width: view.bounds.width - 40, height: view.frame.height / 3)
        let size = image.size
        
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
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let notes = CoreDataHelper.retrieveNote().filter({$0.date == date.toString()})
        notes.map{ CoreDataHelper.deleteNote(note: $0) }
    
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        guard textView.text != "" else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        let notes = CoreDataHelper.retrieveNote().filter({$0.date == date.toString()})
        let noteAtIndex = notes.first
        
        if notes.first == nil {
            // no notes saved before
            let note = CoreDataHelper.newNote()
            note.content = textView.attributedText
            note.date = dateLabel.text
            CoreDataHelper.saveNote()
        } else {
            // note saved before
            noteAtIndex?.content = textView.attributedText
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupView()
        textView.delegate = self
        keyboardListenEvents()
        setupToolBar()
    }
    
    func setupView() {
        let notes = CoreDataHelper.retrieveNote().filter({$0.date == date.toString()})
        let note = notes.first
        textView.attributedText = note?.content ?? NSAttributedString(string: "")
        dateLabel.text = date.toString()
    }
    
    func setupToolBar() {
        
        let addImageButton = UIButton()
        addImageButton.setImage(UIImage(named: "icons8-screenshot-100"), for: .normal)
        addImageButton.imageView?.contentMode = .scaleAspectFit
        addImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        
        let addImageBarButton = UIBarButtonItem(customView: addImageButton)
        
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        bar.barStyle = .default
        bar.items = [addImageBarButton]
        textView.inputAccessoryView = bar
    }
    
    @objc func addImage() {
        openPhotoLibrary()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}



extension DiaryMain {   // keyboard notification handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func keyboardListenEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification: )), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification: )), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func updateTextView(notification: Notification) {
        if let keyboardEndFrameScreenCoord = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let keyboardEndFrame = view.convert(keyboardEndFrameScreenCoord, to: view.window)
            
            if notification.name == Notification.Name.UIKeyboardWillHide {
                textView.contentInset = UIEdgeInsets.zero
            } else {
                textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
                textView.scrollIndicatorInsets = textView.contentInset
            }
            textView.scrollRangeToVisible(textView.selectedRange)
            
        }
    }
}
