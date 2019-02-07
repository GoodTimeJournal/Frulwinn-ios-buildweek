//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class AboutViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var aboutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }
    
    func setTheme() {
        //textfield
        view.backgroundColor = UIColor(patternImage: UIImage(named: "cellWithPlant")!)
    }
}
