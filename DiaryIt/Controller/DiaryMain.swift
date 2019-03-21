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
    var textViewY: CGFloat = 0.0
    
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
        let fullString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        let attachement = NSTextAttachment()
        attachement.image = image
        
        let imageToAttach = NSAttributedString(attachment: attachement)
        
        fullString.append(NSAttributedString(string: "\n"))
        fullString.append(imageToAttach)
        
        textView.attributedText = fullString
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        let targetSize = CGSize(width: view.bounds.width - 30, height: view.frame.height / 2)
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
        textViewY = textView.frame.origin.y
        setupView()
        
        // TODO: Call this when cursor is below bottom of keyboard height
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewChanged), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    @objc private func textViewChanged(notification: Notification) {
        let startPosition: UITextPosition = textView.beginningOfDocument
        let endPosition: UITextPosition = textView.endOfDocument
        if let selectedRange: UITextRange = textView.selectedTextRange {
//            let cursorPosition = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
            let caretPositionRectangle: CGRect = textView.caretRect(for: selectedRange.end)
            print("width of textView: \(textView.frame.size.width)")
            print(caretPositionRectangle.origin)
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        // not good?
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if textView.frame.origin.y == textViewY {
//                self.textView.frame.origin.y -= keyboardSize.height
//            }
//        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        // not good?
//        if self.textView.frame.origin.y != textViewY {
//            self.textView.frame.origin.y = textViewY
//        }
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let screenHeight = (view.bounds.size).height
            let keyboardTop = (screenHeight - (keyboardFrame.size.height))
//            if (currentCursorPosition.y > keyboardTop) {
//                textView.setContentOffset(CGPoint(x: 0, y: (cursorPoint.y - (screenHeight - keyboardFrame.size.height)) + self.textView.contentOffset.y + 25)), animated: true)
//
//            }
        }
    }
 
    func setupView() {
        let notes = CoreDataHelper.retrieveNote().filter({$0.date == date.toString()})
        let note = notes.first
        textView.attributedText = note?.content ?? NSAttributedString(string: "")
        dateLabel.text = date.toString()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        textView.keyboardDismissMode = .onDrag  // TODO: dismiss .onDrag for when users scroll up the textView
    }
    
}
