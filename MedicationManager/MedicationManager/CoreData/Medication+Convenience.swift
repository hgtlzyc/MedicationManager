//
//  Medication+Convenience.swift
//  MedicationManager
//
//  Created by lijia xu on 7/26/21.
//

import CoreData

extension Medication {
    @discardableResult
    convenience init(name: String, timeOfDay: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.timeOfDay = timeOfDay
        self.id = UUID()
    }
    
    func wasTakenToday() -> Bool {
        return (takenDates as? Set<TakenDate>)?.contains(where: { takenDate in
            guard let dateToCompare = takenDate.date else { return false }
            
            return Calendar.current.isDate(dateToCompare, inSameDayAs: Date())
            
        }) ?? false
        
    }
    
    // MARK: - or make it a computed property
    var wasTakenTodayP: Bool {
        return (takenDates as? Set<TakenDate>)?.contains(where: { takenDate in
            guard let dateToCompare = takenDate.date else { return false }
            
            return Calendar.current.isDate(dateToCompare, inSameDayAs: Date())
            
        }) ?? false
    }
    
}//End Of Extensions
