//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var login: UIButton!
    
    @IBAction func login(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty  else { return }
        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
}
