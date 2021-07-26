//
//  MedicationDetailViewController.swift
//  MedicationManager
//
//  Created by lijia xu on 7/26/21.
//

import UIKit

class MedicationDetailViewController: UIViewController {
    
    var medication: Medication?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        
        if let medication = medication {
            MedicationController.shared.updateMedication(medication: medication, name: name, date: datePicker.date)
        } else {
            MedicationController.shared.createMedication(name: name, timeOfDay: datePicker.date)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let medication = medication else { return }
        nameTextField.text = medication.name
        datePicker.date = medication.timeOfDay ?? Date()
    }
    
    
    
}
