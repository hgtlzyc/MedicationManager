//
//  MoodSurveyController.swift
//  MedicationManager
//
//  Created by lijia xu on 7/28/21.
//

import CoreData

class MoodSureveyController {
    
    static let shared = MoodSureveyController()
    
    var todayMoodSurevy: MoodSurvey?
    
    private lazy var fetchRequest: NSFetchRequest<MoodSurvey> = {
        
        let request = NSFetchRequest<MoodSurvey>(entityName: "MoodSurvey")
        
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? Date()
        
        //%@ %K
        let afterPredicate = NSPredicate(format: "date > %@", startOfDay as NSDate)
        let beforePredicate = NSPredicate(format: "date < %@", endOfDay as NSDate)
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [afterPredicate, beforePredicate])
        
        return request
    }()
    
    func didTapMoodEmoji(_ emoji: String) {
        if let currentSurvey = todayMoodSurevy {
            update(moodSurvey: currentSurvey, moodEmoji: emoji)
        } else {
            createMoodSurvey(with: emoji)
        }
    }
    
    
    // MARK: - CRUD Functions
    func fetchMoodSurvey() {
        todayMoodSurevy = try? CoreDataStack.context.fetch(fetchRequest).first
    }
    
    private func createMoodSurvey(with moodEmoji: String) {
        todayMoodSurevy = MoodSurvey(moodState: moodEmoji, date: Date())
        CoreDataStack.saveContext()
    }
    
    private func update(moodSurvey: MoodSurvey, moodEmoji: String) {
        moodSurvey.mentalState = moodEmoji
        CoreDataStack.saveContext()
    }
    
    
    // MARK: - private init
    private init(){}
    
}
