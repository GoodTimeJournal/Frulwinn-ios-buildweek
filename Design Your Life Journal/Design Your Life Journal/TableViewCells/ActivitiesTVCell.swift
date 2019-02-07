//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class ActivitiesTVCell: UITableViewCell {
    
    //MARK: - Properties
    var activity: Activity? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let activity = activity else { return }
        nameLabel.text = activity.name
        engagementNumberLabel.text = String(activity.engagement)
        enjoymentNumberLabel.text = String(activity.enjoymentRating)
        energyNumberLabel.text = String(activity.energyLevel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy, h:mm a"
        
        let timestampFormatted = dateFormatter.string(from: activity.timestamp)
        timestampLabel.text = timestampFormatted
    }
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var engagementLabel: UILabel!
    @IBOutlet weak var enjoymentLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var engagementNumberLabel: UILabel!
    @IBOutlet weak var enjoymentNumberLabel: UILabel!
    @IBOutlet weak var energyNumberLabel: UILabel!
    

}
