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
    @IBOutlet weak var activityTextField: UITextField!
    //rating
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    //engagement
    @IBOutlet weak var engagementView: UIView!
    @IBOutlet weak var engagementLabel: UILabel!
    @IBOutlet weak var engagementTextField: UITextField!
    //enjoyment
    @IBOutlet weak var enjoymentView: UIView!
    @IBOutlet weak var enjoymentLabel: UILabel!
    @IBOutlet weak var enjoymentTextField: UITextField!
    //energy
    @IBOutlet weak var energyView: UIView!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var energyTextField: UITextField!
    
    //save
    @IBAction func save(_ sender: Any) {
        guard let name = activityTextField.text, !name.isEmpty,
            let engagement = engagementTextField.text, !engagement.isEmpty,
            let engagementInt = Int(engagement),
            let enjoymentRating = enjoymentTextField.text, !enjoymentRating.isEmpty,
            let enjoymentRatingInt = Int(enjoymentRating),
            let energyLevel = energyTextField.text, !energyLevel.isEmpty,
            let energyLevelInt = Int(energyLevel) else { return }

        if let activity = activity {
            journalController?.updateActivity(activity: activity, name: name, engagement: engagementInt, enjoymentRating: enjoymentRatingInt, energyLevel: energyLevelInt, fk: 1, completion: { (error) in
                if let error = error {
                    NSLog("Could not update activity: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            //get default fk and place it here
            journalController?.createActivity(name: name, engagement: engagementInt, enjoymentRating: enjoymentRatingInt, energyLevel: energyLevelInt, fk: 1, completion: { (error) in
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
        setTheme()
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let activity = activity else {
                title = "create activity log"
                return
            }
            title = activity.name
            activityTextField.text = activity.name
            engagementTextField.text = String(activity.engagement)
            enjoymentTextField.text = String(activity.enjoymentRating)
            energyTextField.text = String(activity.energyLevel)
        }
    }
    
    func setTheme() {
        //textfield
        engagementView.backgroundColor = UIColor.skyBlue
        engagementLabel.textColor = .white
        engagementTextField.layer.cornerRadius = 5
        engagementTextField.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        engagementTextField.borderStyle = .none
        engagementTextField.textColor = .white
        engagementTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        enjoymentView.backgroundColor = UIColor.skyBlue
        enjoymentLabel.textColor = .white
        enjoymentTextField.layer.cornerRadius = 5
        enjoymentTextField.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        enjoymentTextField.borderStyle = .none
        enjoymentTextField.textColor = .white
        enjoymentTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        energyView.backgroundColor = UIColor.skyBlue
        energyLabel.textColor = .white
        energyTextField.layer.cornerRadius = 5
        energyTextField.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        energyTextField.borderStyle = .none
        energyTextField.textColor = .white
        energyTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        activityTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        activityTextField.textColor = .skyBlue
        activityTextField.layer.cornerRadius = 5
        activityTextField.borderStyle = .none
        activityTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        ratingView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        ratingLabel.textColor = .skyBlue
        ratingLabel.font = Appearance.montserratRegularFont(with: .body, pointSize: 12)
        
        oneLabel.font = Appearance.montserratRegularFont(with: .body, pointSize: 12)
        oneLabel.textColor = .darkBlue
        
        twoLabel.font = Appearance.montserratRegularFont(with: .body, pointSize: 12)
        twoLabel.textColor = .darkBlue
        
        threeLabel.font = Appearance.montserratRegularFont(with: .body, pointSize: 12)
        threeLabel.textColor = .darkBlue
        
        fourLabel.font = Appearance.montserratRegularFont(with: .body, pointSize: 12)
        fourLabel.textColor = .darkBlue
        
        fiveLabel.font = Appearance.montserratRegularFont(with: .body, pointSize: 12)
        fiveLabel.textColor = .darkBlue
        
        view.backgroundColor = .white
    }
}
