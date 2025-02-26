//
//  ViewController+TableView.swift
//  CoreDataUIKit
//
//  Created by thaxz on 08/09/23.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        presentActionSheet(for: item)
    }
    
    // MARK: Actions
    
    /// Presents an action sheet with options to edit or delete a to-do item.
    /// - Parameter item: The `ToDoListItem` to be edited or deleted.
    private func presentActionSheet(for item: ToDoListItem) {
        let sheet = UIAlertController(title: "Choose an option",
                                      message: nil, preferredStyle: .actionSheet)
        
        // Cancel action
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // Edit action
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
            self?.presentEditAlert(for: item)
        }))
        
        // Delete action
        sheet.addAction(UIAlertAction(title: "Delete",
                                      style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
    }
    
    /// Presents an alert to edit an existing to-do item.
    /// - Parameter item: The `ToDoListItem` to be edited.
    private func presentEditAlert(for item: ToDoListItem) {
        let alert = UIAlertController(title: "Edit Item", message: "Edit your item",
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = item.name
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .cancel) { [weak self] _ in
            guard let field = alert.textFields?.first,
                  let newName = field.text,
                  !newName.isEmpty else { return }
            self?.updateItem(item: item, newName: newName)
        }
        
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
}
