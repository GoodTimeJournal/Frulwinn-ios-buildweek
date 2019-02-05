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
        engagementsLabel.text = activity.engagement
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy, h:mm a"
        
        let timestampFormatted = dateFormatter.string(from: activity.timestamp)
        timestampLabel.text = timestampFormatted
    }
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var engagementsLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
}
