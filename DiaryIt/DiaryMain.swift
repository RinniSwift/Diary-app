//
//  DiaryMain.swift
//  DiaryIt
//
//  Created by Rinni Swift on 10/17/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

class DiaryMain: UIViewController {
    
    var date: Date!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        // TODO: CONFORM class to UIImagePickerControllerDelegate, UINavigationControllerDelegate
        // TODO: NEW variable UIImagePicker() conform to UIImagePickerDelegate
        // TODO: NEW function openPhotoLibrary()
        //          presents the imagePicker of source type .photoLibrary
        // TODO: NEW function imagePickerController didFinishPicking
        //          GET image
        //          TODO: NEW function that resizes the picked image
        //          TODO: NEW function that add image to textView
        
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let notes = CoreDataHelper.retrieveNote().filter({$0.date == date.toString()})
        notes.map{ CoreDataHelper.deleteNote(note: $0) }
    
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        guard textView.text != "" else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        let notes = CoreDataHelper.retrieveNote().filter({$0.date == date.toString()})
        let noteAtIndex = notes.first
        
        if notes.first == nil {
            // no notes saved before
            let note = CoreDataHelper.newNote()
            note.content = textView.text
            note.date = dateLabel.text
            CoreDataHelper.saveNote()
        } else {
            // note saved before
            noteAtIndex?.content = textView.text
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let notes = CoreDataHelper.retrieveNote().filter({$0.date == date.toString()})
        let note = notes.first
        textView.text = note?.content ?? ""
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
