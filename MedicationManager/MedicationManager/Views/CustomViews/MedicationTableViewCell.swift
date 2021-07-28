//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by lijia xu on 7/26/21.
//

import UIKit

protocol MedicationCellDelegate: AnyObject {
    func medicationWasTakenTapped(wasTaken: Bool, medication: Medication)
}

class MedicationTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dosageTimeLabel: UILabel!
    @IBOutlet weak var hasBeenTakenButton: UIButton!
    
    weak var delegate: MedicationCellDelegate?
    var medication: Medication?
    private var wasTakenToday: Bool = false
    
    // MARK: - Actions
    @IBAction func hasBeenTakenTapped(_ sender: Any) {
        guard let medication = medication else { return }
        wasTakenToday.toggle()
        delegate?.medicationWasTakenTapped(wasTaken: wasTakenToday, medication: medication)
    }
    
    func congigure(with medication: Medication) {
        self.medication = medication
        wasTakenToday = medication.wasTakenToday()
        
        titleLabel.text = medication.name
        dosageTimeLabel.text = medication.timeOfDay?.dateAsString()
        
        let image = wasTakenToday ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        hasBeenTakenButton.setImage(image, for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        medication = nil
        wasTakenToday =  false
        
    }
    
}
