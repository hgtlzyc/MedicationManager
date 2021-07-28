//
//  MoodSurveyViewController.swift
//  MedicationManager
//
//  Created by lijia xu on 7/28/21.
//

import UIKit

protocol MoodSurveyDelegate: AnyObject {
    func moodButtonTapped(with emoji: String)
}

class MoodSurveyViewController: UIViewController {

    weak var delegate: MoodSurveyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    @IBAction func moodButtonTapped(_ sender: UIButton) {
        guard let moodEmoji = sender.titleLabel?.text else { return }
        
        delegate?.moodButtonTapped(with: moodEmoji)
        
        dismiss(animated: true)
    }
    
}//End Of VC
