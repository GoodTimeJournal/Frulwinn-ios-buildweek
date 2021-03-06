//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBAction func signup(_ sender: Any) {

        guard let name = nameTextField.text, !name.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let username = usernameTextField.text, !username.isEmpty,
            let userPassword = userPasswordTextField.text, !userPassword.isEmpty,
            let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty else { return }
        
        if userPasswordTextField.text != repeatPasswordTextField.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
            let baseURL = URL(string: "https://polar-plateau-24996.herokuapp.com/api/register")!
            let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiIkMmEkMTQkSk8vbHB4RjZKa1MwUVhleFNwMmZHdS9Pc1lvU01URU1TZnF4YURac2VVclFyUkdiR2FiVlciLCJpYXQiOjE1NDk0MjAwODcsImV4cCI6MTU0OTc4MDA4N30.9Ke9kzZ9kCZA97ds-AQZuEm-f_N38rIODkzqA9tkGYk"
            
            var request = URLRequest(url: baseURL)
            request.httpMethod = "POST"
            
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
            
            let user = ["username": usernameTextField.text!,
            "userPassword": userPasswordTextField.text!] as [String: String]
            
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
                        _ = parseJSON["userId"] as? String

                    }
                } catch {
                    print(error)
                }
            }
            dataTask.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        nameTextField.text = ""
        emailTextField.text = ""
        usernameTextField.text = ""
        userPasswordTextField.text = ""
        repeatPasswordTextField.text = ""
    }
    
    func setTheme() {
        title = "Register"
        nameTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        nameTextField.textColor = .darkBlue
        nameTextField.layer.cornerRadius = 4
        nameTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        emailTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        emailTextField.textColor = .darkBlue
        emailTextField.layer.cornerRadius = 4
        emailTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        usernameTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        usernameTextField.textColor = .darkBlue
        usernameTextField.layer.cornerRadius = 4
        usernameTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        userPasswordTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        userPasswordTextField.textColor = .darkBlue
        userPasswordTextField.layer.cornerRadius = 4
        userPasswordTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        repeatPasswordTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        repeatPasswordTextField.textColor = .darkBlue
        repeatPasswordTextField.layer.cornerRadius = 4
        repeatPasswordTextField.font = Appearance.montserratRegularFont(with: .body, pointSize: 15)
        
        Appearance.style(button: signup)
        view.backgroundColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as? LoginViewController else { return }
        guard segue.destination is LoginViewController else { return }
    }
}
