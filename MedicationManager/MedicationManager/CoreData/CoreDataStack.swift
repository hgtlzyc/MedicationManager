//
//  CoreDataStack.swift
//  MedicationManager
//
//  Created by lijia xu on 7/26/21.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MedicationManager")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error loading persistent stores\(error)")
            }
        }
        
        return container
    }()
    
    static var context: NSManagedObjectContext {
        container.viewContext
    }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch  {
                print("Error saving context \(error)")
            }
        }
    }

}//End Of CoreDataStack
