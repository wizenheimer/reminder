//
//  ReminderListView.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChanged(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                case .onSelect(_):
                    print("onSelect")
                case .onCheckedChanged(let reminder, let isCompleted):
                    reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                case .onInfo:
                    print("onInfo")
                }
            }
        }
    }
}

/*
 #Preview {
 ReminderListView()
 }
 */
