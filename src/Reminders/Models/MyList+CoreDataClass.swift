//
//  MyList+CoreDataClass.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { ($0 as! Reminder) } ?? []
    }
}
