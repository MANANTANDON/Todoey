//
//  ViewController.swift
//  Todoey
//
//  Created by Manan Tandon on 10/25/19.
//  Copyright © 2019 MananTandon. All rights reserved.
//

import UIKit

class ToDoeyViewController: UITableViewController{
    
    
    var itemArray = ["APPLE","INSTAGRAM","FACEBOOK","WHATSAPP","MICROSOFT","YOUTUBE","OOH MERI BHARTI!!!!!!! I AM REALLY SORRY :(:(:( "]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = item
        }
        
    }
    
    //MARK: Call two methods of tableDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // this method counts and returns the members inside of an ARRAY...
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //we create an instance of a cell....
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoList", for: indexPath)
        
        //set the text of the property of the table view cell equal to the text inside of an ARRAY......
        cell.textLabel?.text = itemArray[indexPath.row]
        
        //return the instance as mentioned in the return type of this method....
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this will print the index number correspond to the members of an array.....
        print(itemArray[indexPath.row])
        
        

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //this line of code helps in just flashClickingTheSelectedRow as when a user selects a row or any cell it just highlights the cell and quickly unhighlight it giving it a nice animated user interface......
        tableView.deselectRow(at: indexPath, animated: true)
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD ITEM", style: .default) { (action) in
            print(textField.text!)
            self.itemArray.append(textField.text!)
            
            //The below line of code is related to USERDEFAULTS.....
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            print(self.itemArray)
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        present(alert, animated: true, completion: nil)
    }
    

}

