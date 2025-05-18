//
//  PreviewData.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import Foundation
import CoreData

class PreviewData {
    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (
            try? viewContext.fetch(request).first
        ) ?? MyList()
    }
    
    static var reminder: Reminder {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = Reminder.fetchRequest()
        return (
            try? viewContext.fetch(request).first
        ) ?? Reminder(context: viewContext)
    }
}
