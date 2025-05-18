//
//  RemindersApp.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

@main
struct RemindersApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
