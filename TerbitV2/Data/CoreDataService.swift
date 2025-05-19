//
//  DataService.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//


import CoreData

class DataService {
    static let shared = DataService()
    
    let container: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: "TerbitV2Container")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func create<T: NSManagedObject>(_ objectType: T.Type, completion: (T) -> Void) throws {
        let newObject = NSEntityDescription.insertNewObject(
            forEntityName: String(describing: objectType),
            into: managedObjectContext
        ) as! T
        completion(newObject)
        try save()
    }
    
    /// Fetches a list of `objectType` objects from the Core Data store.
    /// - Parameters:
    ///   - objectType: The type of object to fetch.
    ///   - predicate: An optional predicate for filtering the results.
    ///   - sortDescriptors: An optional list of sort descriptors for sorting the results.
    /// - Returns: An array of `objectType` objects.
    func fetch<T: NSManagedObject>(_ objectType: T.Type,
                                   predicate: NSPredicate? = nil,
                                   sortDescriptors: [NSSortDescriptor]? = nil
    ) throws -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: objectType))
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            let objects = try managedObjectContext.fetch(fetchRequest)
            return objects
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Saves the managed object context.
    /// - Parameter completion: A completion block that is called after the save is
    /// complete. The block takes an optional Error as its only argument.
    func save() throws {
        guard managedObjectContext.hasChanges else { return }
        do {
            try managedObjectContext.save()
        } catch {
            managedObjectContext.rollback()
            fatalError(error.localizedDescription)
        }
    }
    
    /// Deletes an NSManagedObject from the managed object context.
    /// - Parameters:
    ///   - object: The NSManagedObject to delete.
    ///   - completion: A closure to be called after the delete operation is completed.
    /// If the delete operation was successful, the error parameter is nil. If the
    /// delete operation failed, the error parameter contains the error that occurred.
    func delete<T: NSManagedObject>(_ object: T) throws {
        managedObjectContext.delete(object)
        try save()
    }
    
    /// Deletes all objects of a given type that match the specified predicate.
    /// - Parameters:
    ///   - objectType: The type of object to delete.
    ///   - predicate: An optional predicate to limit the objects that will be deleted. If `nil`, all objects of the
    ///   given type will be deleted.
    /// - Throws: An error if any of the objects could not be deleted.
    func deleteAll<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil) throws {
        let objects = try fetch(objectType, predicate: predicate)
        for object in objects {
            try delete(object)
        }
    }
    
}
