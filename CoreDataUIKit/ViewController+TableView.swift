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
        addSheet(item: item)
    }
    
    func addSheet(item: ToDoListItem){
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        // all available actions
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // edit action shows an alert with a textfield in it
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
            let alert = UIAlertController(title: "Edit Item", message: "Edit your item", preferredStyle: .alert)
            alert.addTextField()
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: {_ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else { return}
                self?.updateItem(item: item, newName: newName)
            }))
            self?.present(alert, animated: true)
        }))
        
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheet, animated: true)
    }
    
    
}
