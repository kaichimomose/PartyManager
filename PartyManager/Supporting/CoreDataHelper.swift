//
//  CoreDataHelper.swift
//  PartyManager
//
//  Created by Kaichi Momose on 2017/08/07.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import CoreData
import UIKit

class CoreDataHelper: NSManagedObject  {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    //static methods will go here
    
    static func newRecap() -> Recap{
        return NSEntityDescription.insertNewObject(forEntityName: "Recap", into: managedContext) as! Recap
    }
    
    static func saveRecap(){
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(recap: Recap){
        managedContext.delete(recap)
    }
    
    static func retrieveRecap() -> [Recap]{
        let fetchRequest = NSFetchRequest<Recap>(entityName: "Recap")
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }

}
