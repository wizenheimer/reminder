//
//  ReminderListView.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    @State private var selectedReminder: Reminder?
    
    @State private var showReminderDetail: Bool = false
    
    private func reminderCheckedChanged(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    var body: some View {
        VStack {
            List(reminders) { reminder in
                ReminderCellView(isSelected: isReminderSelected(reminder), reminder: reminder) { event in
                    switch event {
                    case .onSelect(let reminder):
                        selectedReminder = reminder
                    case .onCheckedChanged(let reminder, let isCompleted):
                        reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                    case .onInfo:
                        showReminderDetail = true
                    }
                }
            }.listStyle(.inset)
        }.sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}

/*
 #Preview {
 ReminderListView()
 }
 */
