//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by lijia xu on 7/26/21.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dosageTimeLabel: UILabel!
    @IBOutlet weak var hasBeenTakenButton: UIButton!
 
    // MARK: - Actions
    @IBAction func hasBeenTakenTapped(_ sender: Any) {
        
    }
    
    func congigure(with medication: Medication) {
        titleLabel.text = DateFormatter.medicationTime.string(from: medication.timeOfDay ?? Date())
    }
    
}
