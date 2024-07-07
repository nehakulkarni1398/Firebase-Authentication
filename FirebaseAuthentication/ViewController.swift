//
//  ViewController.swift
//  FirebaseAuthentication
//
//  Created by Mandar Choudhary on 18/06/24.
//

import UIKit
import FirebaseAuth
import Toast

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func navigateToTodoList(_ sender: UIBarButtonItem) {
        guard let todoListViewController = storyboard?.instantiateViewController(withIdentifier: "TodoListTableViewController") as? TodoListTableViewController else {return}
        navigationController?.pushViewController(todoListViewController, animated: true)
        
    }
    @IBAction func signUpButtonTap(_ sender: UIButton) {
        guard let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return}
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    @IBAction func LoginButtonTAP(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error == nil{
                self.view.makeToast("Login Successful")
            }
            else {
                self.view.makeToast(error?.localizedDescription)
            }
        }
    }
}

