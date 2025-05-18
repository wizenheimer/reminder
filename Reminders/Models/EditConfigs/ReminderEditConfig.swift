//
//  ReminderEditConfig.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import Foundation

// EditConfigs capture the edits made to fields

struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleted: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var reminderDate: Date?
    var reminderTime: Date?
    
    init() {}
    
    init(reminder: Reminder) {
        title = reminder.title ?? ""
        notes = reminder.notes
        isCompleted = reminder.isCompleted
        reminderDate = reminder.reminderDate ?? Date()
        reminderTime = reminder.reminderTime ?? Date()
        hasDate = reminder.reminderDate != nil
        hasTime = reminder.reminderTime != nil
    }
}
