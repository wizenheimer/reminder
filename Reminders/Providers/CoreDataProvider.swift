//
//  CoreDataProvider.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import Foundation
import CoreData

// Responsible for setting the core data
class CoreDataProvider {
    
    // This ensures CoreDataProvider operates as a singleton
    static let shared = CoreDataProvider()
    
    let persistentContainer: NSPersistentContainer
    
    // By making the initializer private this cannot be called from outside
    private init() {
        // register the custom  transformer
        ValueTransformer.setValueTransformer(
            UIColorTransformer(),
            forName: NSValueTransformerName(rawValue: "UIColorTransformer")
        )
        
        
        // prepare the persistent container
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error initializing RemindersModel: \(error.localizedDescription)")
            }
        }
    }
    
}
