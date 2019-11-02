//
//  ViewController.swift
//  Todoey
//
//  Created by Manan Tandon on 10/25/19.
//  Copyright © 2019 MananTandon. All rights reserved.
//

import UIKit

class ToDoeyViewController: UITableViewController{
    
    
    var itemArray = [Items]()
   //        ["APPLE","INSTAGRAM","FACEBOOK","WHATSAPP","MICROSOFT","YOUTUBE","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    //,"OOH MERI BHARTI!!!!!!! I AM REALLY SORRY, BE HAPPY ALWAYS :):):) "]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Items()
        newItem.titles = "APPLE"
        itemArray.append(newItem)
        
        let newItemTwo = Items()
        newItemTwo.titles = "INSTAGRAM"
        itemArray.append(newItemTwo)
        
        let newItemThree = Items()
        newItemThree.titles = "FACEBOOK"
        itemArray.append(newItemThree)
        
        
        if let item = defaults.array(forKey: "TodoListArray") as? [Items]{
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
        
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.titles
        
        cell.accessoryType = item.done ? .checkmark : .none
       
        
        //return the instance as mentioned in the return type of this method....
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this will print the index number correspond to the members of an array.....
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
      
        tableView.reloadData()
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
    @IBAction func startEditing(_ sender: Any) {
        
        isEditing = !isEditing
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //this line of code adds an editing button wiz a bar button on the navigation bar and also helps in editing the cell in the UITableViewController...
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = itemArray[sourceIndexPath.row]
        itemArray.remove(at: sourceIndexPath.row)
        itemArray.insert(itemToMove, at: sourceIndexPath.row)
    }
    
    
    //this line of code deletes an element from the from the table view controller........
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
               print("Item DELETED!!!!!!!")
            self.itemArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD ITEM", style: .default) { (action) in
          
            
            let newItem = Items()
            newItem.titles = textField.text!
            
            self.itemArray.append(newItem)
            
            //The below line of code is related to USERDEFAULTS.....
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
            
            self.tableView.reloadData()
        }
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

