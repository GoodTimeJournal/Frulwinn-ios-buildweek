//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class ReflectionsDetailVC: UIViewController {
    
    //MARK: - Properties
    var journalController: JournalController?
    var reflection: Reflection? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var journalEntryTextField: UITextField!
    @IBOutlet weak var weekTextField: UITextField!
    @IBOutlet weak var surprisesTextView: UITextView!
    @IBOutlet weak var insightsTextView: UITextView!
    @IBOutlet weak var trendsTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        guard let journalEntry = journalEntryTextField.text, !journalEntry.isEmpty,
            let surprises = surprisesTextView.text, !surprises.isEmpty,
            let insights = insightsTextView.text, !insights.isEmpty,
            let trends = trendsTextView.text, !trends.isEmpty,
            let week = weekTextField.text, !week.isEmpty else { return }
        //print("hello")
        if let reflection = reflection {
            journalController?.updateReflection(reflection: reflection, journalEntry: journalEntry, surprises: surprises, insights: insights, trends: trends, week: week, fk: 1, completion: { (error) in
                if let error = error {
                    NSLog("Could not update reflection: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            journalController?.createReflection(journalEntry: journalEntry, surprises: surprises, insights: insights, trends: trends, week: week, fk: 1, id: 2, completion: { (error) in
                if let error = error {
                    NSLog("Could not create reflection: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let reflection = reflection else {
                title = "create reflection"
                return
            }
            title = reflection.journalEntry
            surprisesTextView.text = reflection.surprises
            insightsTextView.text = reflection.insights
            trendsTextView.text = reflection.trends
        }
    }
    
    func setTheme() {
        //textfield
        journalEntryTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        journalEntryTextField.textColor = .skyBlue
        journalEntryTextField.borderStyle = .none
        journalEntryTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        weekTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        weekTextField.textColor = .skyBlue
        weekTextField.borderStyle = .none
        weekTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        insightsTextView.backgroundColor = .skyBlue
        insightsTextView.textColor = .white
        insightsTextView.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        surprisesTextView.backgroundColor = .skyBlue
        surprisesTextView.textColor = .white
        surprisesTextView.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        trendsTextView.backgroundColor = .skyBlue
        trendsTextView.textColor = .white
        trendsTextView.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        view.backgroundColor = .white
    }
}

//energyView.backgroundColor = UIColor.skyBlue
//energyLabel.textColor = .white
//energyTextField.layer.cornerRadius = 5
//energyTextField.backgroundColor = UIColor.white.withAlphaComponent(0.25)
//energyTextField.borderStyle = .none
//energyTextField.textColor = .white
//energyTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
