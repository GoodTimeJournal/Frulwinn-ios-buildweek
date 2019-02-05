//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit



class ActivitiesDetailVC: UIViewController {
    
    //MARK: - Properties
    var journalController: JournalController?
    var activity: Activity? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var engagementsView: UITextView!
    @IBOutlet weak var enjoymentRatingLabel: UILabel!
    @IBOutlet weak var enjoymentRatingControl: UISegmentedControl!
    @IBAction func enjoymentRatingControl(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
            let engagement = engagementsView.text, !engagement.isEmpty else { return }
        
        if let activity = activity {
            journalController?.updateActivity(activity: activity, name: name, engagement: engagement, enjoymentRating: enjoymentRatingControl, completion: { (error) in
                if let error = error {
                    NSLog("Could not update activity: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            journalController?.createActivity(name: name, engagement: engagement, enjoymentRating: enjoymentRatingLabe, completion: { (error) in
                if let error = error {
                    NSLog("Could not create activity: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let activity = activity else {
                title = "create activity log"
                return
            }
            title = activity.name
            nameTextField.text = activity.name
            engagementsView.text = activity.engagement
            //enjoymentRatingControl.text = activity.enjoymentRating
        }
    }
}
