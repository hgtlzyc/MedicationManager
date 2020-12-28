//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import UIKit

class MedicationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        MedicationController.shared.fetchMedications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditMedication",
           let destination = segue.destination as? MedicationDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
            destination.medication = medication
        }
    }

}

extension MedicationListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        MedicationController.shared.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MedicationController.shared.sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicationTableViewCell
        else { return UITableViewCell() }

        let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]

        cell.delegate = self
        cell.configure(with: medication)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Not Taken"
        } else if section == 1 {
            return "Taken"
        }
        return nil
    }
    
}

extension MedicationListViewController: MedicationCellDelegate {
    func medicationWasTakenTapped(wasTaken: Bool, medication: Medication, cell: MedicationTableViewCell) {
        MedicationController.shared.updateMedicationTakenStatus(wasTaken, medication: medication)
        tableView.reloadData()
    }
}
