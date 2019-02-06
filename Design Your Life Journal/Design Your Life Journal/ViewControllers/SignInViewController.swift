//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class SignInViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var createNewAccountButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func login(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        
        let baseURL = URL(string: "https://polar-plateau-24996.herokuapp.com/api/login")!
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk"
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        
        let user = ["username": usernameTextField.text!,
                    "password": passwordTextField.text!] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: user, options: .prettyPrinted)
        } catch {
            NSLog("error creating username and password: \(error)")
            return
        }
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("error creating user data: \(error)")
                //completion(error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    let accessToken = parseJSON["token"] as? String
                    let id = parseJSON["id"] as? String
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
    
    @IBAction func createNewAccountButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    func setTheme() {
        //textfield
        view.backgroundColor = .lightGray

    }
    
}

