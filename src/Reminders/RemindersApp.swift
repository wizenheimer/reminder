//
//  RemindersApp.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI
import UserNotifications


@main
struct RemindersApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            
        }
    }
    
    
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
