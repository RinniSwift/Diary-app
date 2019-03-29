//
//  CoreDataHelper.swift
//  DiaryIt
//
//  Created by Rinni Swift on 10/18/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import CoreData
import UIKit

struct CoreDataHelper {
    
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        return note
    }
    
    static func newNotification(date: String) -> NotificationEntity {
        let notification = NSEntityDescription.insertNewObject(forEntityName: "NotificationEntity", into: context) as! NotificationEntity
        return notification
    }
    
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("could not save \(error.localizedDescription)")
        }
    }
    
    static func deleteNote(note: Note) {
        context.delete(note)
        saveNote()
    }
    
    static func retrieveNote() -> [Note] {
        do {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("could not fetch \(error.localizedDescription)")
            return []
        }
    }
    
    static func retrieveNotifications() -> [NotificationEntity] {
        do {
            let fetchRequest = NSFetchRequest<NotificationEntity>(entityName: "NotificationEntity")
            let results = try context.fetch(fetchRequest)
            return results
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
}
