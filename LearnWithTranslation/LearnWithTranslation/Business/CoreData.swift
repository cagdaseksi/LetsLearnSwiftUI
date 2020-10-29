//
//  CoreData.swift
//  LearnWithTranslation
//
//  Created by MAC on 27.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Service {
    
    static var v1: Service = {
        return Service()
    }()

    func createData(subCategoryCore: SubCategoryCoreData){
        
        print(subCategoryCore.subCategoryId)
        print(subCategoryCore.isDone)
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "SubCategoryCore", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(subCategoryCore.isDone, forKeyPath: "isdone")
        user.setValue(subCategoryCore.subCategoryId, forKeyPath: "subcategoryid")
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func someEntityExists(subcategoryid: Int) -> Bool {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return true }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<SubCategoryCore>(entityName: "SubCategoryCore")
        //fetchRequest.predicate = NSPredicate(format: "subcategoryid = %d", subcategoryid)
        let key1 = NSPredicate(format: "subcategoryid = %d", Int32(subcategoryid))
        //let key2 = NSPredicate(format: "id = %@", id)
        
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [key1])
        fetchRequest.predicate = andPredicate
        var results: [SubCategoryCore] = []
        
        do {
            results = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
        
    }

    func delete(entity:String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
             try managedContext.execute(deleteRequest)
            print("Detele all data in \(entity)")
        } catch let error as NSError {
            print("Detele all data in \(entity) error :", error)
        }

        
    }
    
    func getAllSubCategory() -> [SubCategoryCore] {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [SubCategoryCore]() }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<SubCategoryCore>(entityName: "SubCategoryCore")
        //fetchRequest.predicate = NSPredicate(format: "subcategoryid = %d", subCategoryId)
        //let key1 = NSPredicate(format: "subcategoryid = %d", subCategoryId)
        //let key2 = NSPredicate(format: "id = %@", id)
        
        //let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [key1])
        //fetchRequest.predicate = andPredicate
        var results: [SubCategoryCore] = []
        
        do {
            results = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results
        
    }

    func createCategoryData(categoryCore: CategoryCoreData){
        
        print(categoryCore.categoryId)
        print(categoryCore.isDone)
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "CategoryCore", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(categoryCore.isDone, forKeyPath: "isdone")
        user.setValue(categoryCore.categoryId, forKeyPath: "categoryid")
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func someEntityExists(categoryid: Int) -> Bool {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return true }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CategoryCore>(entityName: "CategoryCore")
        //fetchRequest.predicate = NSPredicate(format: "subcategoryid = %d", subcategoryid)
        let key1 = NSPredicate(format: "categoryid = %d", Int32(categoryid))
        //let key2 = NSPredicate(format: "id = %@", id)
        
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [key1])
        fetchRequest.predicate = andPredicate
        
        var results: [CategoryCore] = []
        
        do {
            results = try managedContext.fetch(fetchRequest)
            //print("results.count", results)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
        
    }
    
    func someEntityExists(topCategoryid: Int) -> Bool {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return true }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<TopCategoryCore>(entityName: "TopCategoryCore")
        //fetchRequest.predicate = NSPredicate(format: "subcategoryid = %d", subcategoryid)
        let key1 = NSPredicate(format: "topcategoryid = %d", Int32(topCategoryid))
        //let key2 = NSPredicate(format: "id = %@", id)
        
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [key1])
        fetchRequest.predicate = andPredicate
        
        var results: [TopCategoryCore] = []
        
        do {
            results = try managedContext.fetch(fetchRequest)
            //print("results.count", results)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
        
    }
    
    func getAllCategory() -> [CategoryCore] {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [CategoryCore]() }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CategoryCore>(entityName: "CategoryCore")
        //fetchRequest.predicate = NSPredicate(format: "subcategoryid = %d", subCategoryId)
        //let key1 = NSPredicate(format: "subcategoryid = %d", subCategoryId)
        //let key2 = NSPredicate(format: "id = %@", id)
        
        //let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [key1])
        //fetchRequest.predicate = andPredicate
        var results: [CategoryCore] = []
        
        do {
            results = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results
        
    }
    
    func createTopCategoryData(topCategoryCore: TopCategoryCoreData){
        
        print("create top category data")
        print(topCategoryCore.topCategoryId)
        print(topCategoryCore.isDone)
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "TopCategoryCore", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(topCategoryCore.isDone, forKeyPath: "isdone")
        user.setValue(topCategoryCore.topCategoryId, forKeyPath: "topcategoryid")
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
