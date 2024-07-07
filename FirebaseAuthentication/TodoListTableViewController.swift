//
//  TodoListTableViewController.swift
//  FirebaseAuthentication
//
//  Created by Mandar Choudhary on 24/06/24.
//

import UIKit
import FirebaseDatabase

class TodoListTableViewController: UIViewController {

    @IBOutlet weak var todoListTableView: UITableView!
    
    var todoArray : [[String : String]] = [[:]]
    override func viewDidLoad() {
        super.viewDidLoad()

        Database.database().reference().child("Todo").observe(.value) { snapshot in
            self.todoArray = []
            for child in snapshot.children
            {
                guard let value = (child as? DataSnapshot)?.value as? [String : String] else {return}
                self.todoArray.append(value)
            }
            
            DispatchQueue.main.async {
                self.todoListTableView.reloadData()
            }
        }
        
    }
    
    
    @IBAction func navigateToAddTodo(_ sender: UIBarButtonItem) {
        guard let addTodoViewController = storyboard?.instantiateViewController(withIdentifier: "AddTodoViewController") as? AddTodoViewController else {return}
        navigationController?.pushViewController(addTodoViewController, animated: true)
    }
}

extension TodoListTableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell.init()}
        let obj = todoArray[indexPath.row]
        cell.textLabel?.text = obj["title"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let obj = todoArray[indexPath.row]
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (act, view, nil) in
        
            let alertController = UIAlertController(title: "Edit", message: "Do you want to edit?", preferredStyle: .alert)
            alertController.addTextField()
            alertController.textFields![0].text = obj["title"]
            let okAction = UIAlertAction(title: "Ok", style: .default) { act in
                Database.database().reference().child("Todo").child(obj["id"]!).updateChildValues(["title": alertController.textFields![0].text!])
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
            
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (act, view, nil) in
            Database.database().reference().child("Todo").child(obj["id"]!).removeValue()
        }
        return  UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
}
