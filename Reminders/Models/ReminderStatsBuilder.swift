//
//  ReminderStatsBuilder.swift
//  Reminders
//
//  Created by Nayan on 19/05/25.
//

import Foundation
import SwiftUI

enum ReminderStatType {
    case today
    case all
    case scheduled
    case completed
}

struct ReminderStatsValue {
    var todayCount: Int = 0
    var scheduledCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
}

struct ReminderStatsBuilder {
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValue {
        let remindersArray: [Reminder] = myListResults.map {
            $0.remindersArray
        }.reduce([], +)
        
        let allCount = calculateAllCount(reminders: remindersArray)
        let completedCount = calculateAllCount(reminders: remindersArray)
        let todayCount = calculateTodayCount(reminders: remindersArray)
        let scheduledCount = calculateScheduledCount(reminders: remindersArray)
        
        
        return ReminderStatsValue(
            todayCount: todayCount,
            scheduledCount: scheduledCount,
            allCount: allCount,
            completedCount: completedCount
        )
    }
    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleted) ? result + 1 : result
        }
    }
    
    private func calculateTodayCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return result + 1
        }
    }
    
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
}
