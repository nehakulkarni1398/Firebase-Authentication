//
//  SignUpViewController.swift
//  FirebaseAuthentication
//
//  Created by Mandar Choudhary on 18/06/24.
//

import UIKit
import FirebaseAuth
import Toast

class SignUpViewController: UIViewController {

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpActionTap(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: userNameTextField.text!, password: passwordTextField.text!) { Result, error in
            if error == nil{
                self.view.makeToast("Registration Done ")
            }
            else {
                self.view.makeToast(error?.localizedDescription)
            }
        }
    }
}
