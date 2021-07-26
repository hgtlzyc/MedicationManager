//
//  MedicationController.swift
//  MedicationManager
//
//  Created by lijia xu on 7/26/21.
//

import CoreData

class MedicationController {
    
    static let shared = MedicationController()
    
    var medications: [Medication] = []
    
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        
        request.predicate = NSPredicate(value: true)
        
        return request
    }()
    
    private init(){}
    
    // MARK: - CRUD Functions
    
    func createMedication(name: String, timeOfDay: Date ) {
        let medication = Medication(name: name, timeOfDay: timeOfDay)
        medications.append(medication)
        CoreDataStack.saveContext()
    }
    
    func fetchMedication() {
        let medications = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        self.medications = medications
    }
    
    func updateMedication(medication: Medication, name: String, date: Date) {
        medication.name = name
        medication.timeOfDay = date
        CoreDataStack.saveContext()
        
    }
    
    func deleteMedication() {
        
    }
    
}
