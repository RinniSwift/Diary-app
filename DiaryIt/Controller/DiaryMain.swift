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

class DiaryMain: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        self.dismiss(animated: true, completion: nil)
        
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
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let notes = CoreDataHelper.retrieveNote().filter({$0.date == date.toString()})
        let note = notes.first
        textView.attributedText = note?.content ?? NSAttributedString(string: "")
        dateLabel.text = date.toString()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        textView.keyboardDismissMode = .onDrag
    }
}

extension Date{
    
    func toString() -> String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy MMMM dd"
        
        let myString = formatter.string(from: self) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd MMMM"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
}
