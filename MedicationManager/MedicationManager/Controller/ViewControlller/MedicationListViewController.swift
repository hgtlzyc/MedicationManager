//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by lijia xu on 7/26/21.
//

import UIKit

class MedicationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var moodSurveyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        MedicationController.shared.fetchMedication()
        MoodSureveyController.shared.fetchMoodSurvey()
        
        moodSurveyButton.setTitle(MoodSureveyController.shared.todayMoodSurevy?.mentalState ?? "❓", for: .normal)
        
    }
    
    @IBAction func moodSurveyButtonTapped(_ sender: Any) {

        guard let moodSurveyVC =  storyboard?.instantiateViewController(withIdentifier: "moodSurveyVC") as? MoodSurveyViewController else { return }
        
        moodSurveyVC.modalPresentationStyle = .fullScreen
        moodSurveyVC.delegate = self
        navigationController?.present(moodSurveyVC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditMedicationVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? MedicationDetailViewController else { return }
            let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
            destination.medication = medication
            
        }
    }

}

extension MedicationListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        MedicationController.shared.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationController.shared.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicationTableViewCell else { return UITableViewCell() }
        
        let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
        
        cell.congigure(with: medication)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Not Taken"
        } else if section == 1 {
            return "Taken"
        }
        return ""
    }
    
}

extension MedicationListViewController: MedicationCellDelegate {
    func medicationWasTakenTapped(wasTaken: Bool, medication: Medication) {
        MedicationController.shared.updateMedicationStatus(wasTaken, medication: medication)
        tableView.reloadData()
    }
}

extension MedicationListViewController: MoodSurveyDelegate {
    func moodButtonTapped(with emoji: String) {
        moodSurveyButton.setTitle(emoji, for: .normal)
        MoodSureveyController.shared.didTapMoodEmoji(emoji)
    }
    
}
