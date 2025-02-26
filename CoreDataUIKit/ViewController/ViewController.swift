//
//  ViewController.swift
//  CoreDataUIKit
//
//  Created by thaxz on 08/09/23.
//

import UIKit

/// Main ViewController responsible for managing a list of to-do items stored using Core Data
class ViewController: UIViewController {
    
    /// Accessing the Core Data context from the app delegate.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    /// Array of `ToDoListItem`
    var models: [ToDoListItem] = []
    
    /// The table view used to display the list of to-do items.
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Core Data List"
        setupUI()
        getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// Configures the user interface
    func setupUI(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    
    /// Handles the action when the add button is tapped.
    @objc func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Enter new item",
                                      preferredStyle: .alert)
        alert.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .cancel) { [weak self] _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.isEmpty else { return }
            self?.createItem(with: text)
        }
        alert.addAction(submitAction)
        present(alert, animated: true)
    }
    
    //MARK: CoreData
    
    /// Fetches all `ToDoListItem` objects from Core Data and updates the table view.
    func getAllItems(){
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    /// Creates a new `ToDoListItem` and saves it to Core Data.
    /// - Parameter name: The name of the new to-do item.
    func createItem(with name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        do {
            try context.save()
            getAllItems()
        } catch {
            print("Failed to save new item: \(error.localizedDescription)")
        }
    }
    
    /// Deletes a `ToDoListItem` from Core Data.
    /// - Parameter item: The item to be deleted.
    func deleteItem(item: ToDoListItem){
        context.delete(item)
        do {
            try context.save()
            getAllItems()
        } catch {
            print("Failed to delete item: \(error.localizedDescription)")
        }
    }
    
    /// Updates an existing `ToDoListItem` with a new name.
    /// - Parameters:
    ///   - item: The item to be updated.
    ///   - newName: The new name for the item.
    func updateItem(item: ToDoListItem, newName: String){
        item.name = newName
        do {
            try context.save()
            getAllItems()
        } catch {
            print("Failed to update item: \(error.localizedDescription)")
        }
    }
}

