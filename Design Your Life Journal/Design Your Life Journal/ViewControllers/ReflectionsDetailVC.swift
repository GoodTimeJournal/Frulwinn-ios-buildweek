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
    @IBOutlet weak var surprisesTextView: UITextView!
    @IBOutlet weak var insightsTextView: UITextView!
    @IBAction func save(_ sender: Any) {
        guard let journalEntry = journalEntryTextField.text, !journalEntry.isEmpty,
        let surprises = surprisesTextView.text, !surprises.isEmpty,
            let insights = insightsTextView.text, !insights.isEmpty else { return }
        print("hello")
        if let reflection = reflection {
            journalController?.updateReflection(reflection: reflection, journalEntry: journalEntry, surprises: surprises, insights: insights, completion: { (error) in
                if let error = error {
                    NSLog("Could not update reflection: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            journalController?.createReflection(journalEntry: journalEntry, surprises: surprises, insights: insights, completion: { (error) in
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
                title = "create reflection log"
                return
            }
            title = reflection.journalEntry
            surprisesTextView.text = reflection.suprises
            insightsTextView.text = reflection.insights
        }
    }
    
    func setTheme() {
        //textfield
        view.backgroundColor = .lightGray
    }
}
