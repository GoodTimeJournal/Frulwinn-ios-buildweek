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
    @IBOutlet weak var engatementsView: UITextView!
    @IBOutlet weak var enjoymentRatingLabel: UILabel!
    @IBOutlet weak var enjoymentRatingControl: UISegmentedControl!
    @IBAction func save(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
