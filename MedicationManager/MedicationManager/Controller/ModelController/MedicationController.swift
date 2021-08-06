//
//  MedicationController.swift
//  MedicationManager
//
//  Created by lijia xu on 7/26/21.
//

import CoreData

class MedicationController {
    
    static let shared = MedicationController()
    
    /// index 0 == notTaken, index 1 == tanken
    var sections: [[Medication]] { [notTakenMeds, takenMeds] }
    var notTakenMeds: [Medication] = []
    var takenMeds: [Medication] = []
    
    private let notificationScheduler = NotificationScheluler()
    
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        
        request.predicate = NSPredicate(value: true)
        
        return request
    }()
    
    private init(){}
    
    // MARK: - CRUD Functions
    
    func createMedication(name: String, timeOfDay: Date ) {
        let medication = Medication(name: name, timeOfDay: timeOfDay)
        notTakenMeds.append(medication)
        CoreDataStack.saveContext()
        notificationScheduler.scheduleNotification(for: medication)
    }
    
    func fetchMedication() {
        let medications = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        
        takenMeds = medications.filter{ $0.wasTakenToday() }
        notTakenMeds = medications.filter{ !$0.wasTakenToday() }
        
//        let sections2dArr = Dictionary.init(grouping: medications) { $0.wasTakenToday() }.sorted { $0.key && !$1.key }.map{ $0.value }
//        print(sections2dArr)
        
    }
    
    func updateMedicationDetails(medication: Medication, name: String, date: Date) {
        medication.name = name
        medication.timeOfDay = date
        CoreDataStack.saveContext()
        
        if !medication.wasTakenToday() {
            notificationScheduler.clearNotification(for: medication)
            notificationScheduler.scheduleNotification(for: medication)
        }
        
    }
    
    func updateMedicationStatus(_ wasTaken: Bool, medication: Medication) {
        if wasTaken {
            TakenDate(date: Date(), medication: medication)
            if let index = notTakenMeds.firstIndex(of: medication) {
                notTakenMeds.remove(at: index)
                takenMeds.append(medication)
                notificationScheduler.clearNotification(for: medication)
            }
            
        } else {
            let mutableTakenDates = medication.mutableSetValue(forKey: "takenDates")
            
            if let takenDate = (mutableTakenDates as? Set<TakenDate>)?.first(where: { takenDate in
                guard let date = takenDate.date else { return false }
                return Calendar.current.isDate(date, inSameDayAs: Date())
            }) {
                mutableTakenDates.remove(takenDate)
                if let index = takenMeds.firstIndex(of: medication){
                    takenMeds.remove(at: index)
                    notTakenMeds.append(medication)
                    notificationScheduler.scheduleNotification(for: medication)
                }
            }
        }
        CoreDataStack.saveContext()
    }
    
    func markMedicationAsTanken(withID id: String) {
        guard let uuid = UUID(uuidString: id),
              let medication = notTakenMeds.first(where: {$0.id == uuid}) else { return }
        
        TakenDate(date: Date(), medication: medication)
        
        CoreDataStack.saveContext()
        
    }
    
    func deleteMedication(_ medication: Medication) {
        
        CoreDataStack.context.delete(medication)
        CoreDataStack.saveContext()
        fetchMedication()
        notificationScheduler.clearNotification(for: medication)
    }
    
}
