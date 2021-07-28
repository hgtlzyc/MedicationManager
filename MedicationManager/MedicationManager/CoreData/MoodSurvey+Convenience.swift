//
//  MoodSurvey+Convenience.swift
//  MedicationManager
//
//  Created by lijia xu on 7/28/21.
//

import CoreData

extension MoodSurvey {
    
    @discardableResult
    convenience init(moodState: String, date: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.mentalState = moodState
        self.date = date
    }
    
}
