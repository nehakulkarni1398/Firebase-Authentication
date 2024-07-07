//
//  AddTodoViewController.swift
//  FirebaseAuthentication
//
//  Created by Mandar Choudhary on 24/06/24.
//

import UIKit
import FirebaseDatabase

class AddTodoViewController: UIViewController {

    @IBOutlet weak var todoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveTodoButton(_ sender: UIButton) {
        
        guard let id = Database.database().reference().child("Todo").childByAutoId().key else {return} ;
        guard let todoValue = todoTextField.text else {return}
        Database.database().reference().child("Todo").child(id).updateChildValues(["id": id, "title": todoValue])
        navigationController?.popViewController(animated: true)
    }
    
}
