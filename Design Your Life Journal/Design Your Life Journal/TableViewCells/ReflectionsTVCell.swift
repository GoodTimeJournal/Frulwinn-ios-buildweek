//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class ReflectionsTVCell: UITableViewCell {
    
    //MARK: - Properties
    var reflection: Reflection? {
        didSet {
            updateViews()
        }
    }

    //MARK: - Outlets
    @IBOutlet weak var journalEntryLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    private func updateViews() {
        guard let reflection = reflection else { return }
        journalEntryLabel.text = reflection.journalEntry
        timestampLabel.text = reflection.timestamp
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "M/d/yy, h:mm a"
//
//        let timestampFormatted = dateFormatter.string(from: reflection.timestamp)
//        timestampLabel.text = timestampFormatted
    }
}
