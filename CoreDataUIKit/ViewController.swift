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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Fetching all the items from our database
    func getAllItems(){
        do {
            let items = try context.fetch(ToDoListItem.fetchRequest())
        } catch {
            // do something
        }
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

