//
//  ViewController.swift
//  taskManager
//
//  Created by Cristi_Tohatan on 27/07/2018.
//  Copyright © 2018 Cristi_Tohatan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        loadItems()
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //ternary conditions: value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true) 
    }
    
    //MARK - model manipulation methods
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item")
        }
    }
    //MARK - add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add task", style: .default) { (action) in
            //what happens after user clicks add item button
            
            let newItem = Item()
            newItem.title = textField.text!

            self.itemArray.append(newItem)
            self.saveItems()
            let encoder = PropertyListEncoder()
            do{
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            }catch{
                print("Error encoding item")
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField(configurationHandler: { (alertTextField) in
            alertTextField.placeholder = "NEW TASK"
            textField = alertTextField
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems(){
    
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item")
            }
        }
    }
    
    
    
    
    
    
    
    
    
}

