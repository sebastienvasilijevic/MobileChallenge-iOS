//
//  DB.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import UIKit
import CoreData

class DB {
    static let shared = DB()
    
    var persistentContainer: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public func saveContext() {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
