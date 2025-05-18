//
//  NotificationManager.swift
//  Reminders
//
//  Created by Nayan on 19/05/25.
//

import Foundation
import UserNotifications

struct UserData {
    let title: String? // Title of the reminder
    let body: String? // Notes within the reminder
    let date: Date? // Dates from reminder
    let time: Date? // Time from reminder
}

class NotificationManager {
    static func scheduleNotification(userData: UserData) {
        let content = UNMutableNotificationContent()
        content.title = userData.title ?? ""
        content.body = userData.body ?? ""
        
        // Now break the date into components
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userData.date ?? Date())
        
        // Now offset the date component based on time component
        if let reminderTime = userData.time {
            let reminderTimeDateComponents = reminderTime.dateComponents
            
            dateComponents.hour = reminderTimeDateComponents.hour
            dateComponents.minute = reminderTimeDateComponents.minute
            
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(UUID())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}
