//
//  ViewController.swift
//  CoreDataUIKit
//
//  Created by thaxz on 08/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    // acessing context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models: [ToDoListItem] = []
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Core Data List"
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    //MARK: CoreData
    
    // Fetching all the items from our database
    func getAllItems(){
        do {
           models = try context.fetch(ToDoListItem.fetchRequest())
            // back to the main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {}
    }
    
    func createItem(name: String){
        // creating
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        // saving
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func deleteItem(item: ToDoListItem){
        context.delete(item)
        // saving
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String){
        item.name = newName
        do {
            try context.save()
        } catch {
            
        }
    }
    
}

