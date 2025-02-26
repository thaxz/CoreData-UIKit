//
//  ToDoListItem+CoreDataProperties.swift
//  CoreDataUIKit
//
//  Created by thaxz on 08/09/23.
//
//

import Foundation
import CoreData

/// An extension of `ToDoListItem` that defines its properties and provides a fetch request method.
extension ToDoListItem {

    /// Creates and returns a fetch request for retrieving `ToDoListItem` objects from Core Data.
    /// - Returns: An `NSFetchRequest` instance configured to fetch `ToDoListItem` entities.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    /// The name of the item
    @NSManaged public var name: String?
    /// The date and time when the item was created
    @NSManaged public var createdAt: Date?

}

/// Conforms `ToDoListItem` to the `Identifiable` protocol
extension ToDoListItem : Identifiable {

}
