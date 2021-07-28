//
//  TakenDate+Convenience.swift
//  MedicationManager
//
//  Created by lijia xu on 7/27/21.
//

import CoreData

extension TakenDate {
    
    @discardableResult
    convenience init( date: Date, medication: Medication, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.date = date
        self.medication = medication
    }
    
}//End Of TankenDate
