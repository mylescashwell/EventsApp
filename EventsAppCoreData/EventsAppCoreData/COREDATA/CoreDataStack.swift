//
//  CoreDataStack.swift
//  EventsAppCoreData
//
//  Created by Myles Cashwell on 4/30/21.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "EventsAppCoreData")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading Persistent Store's \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }
    
    static func saveContext() {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context\(error)")
            }
            
        }
    }
}
