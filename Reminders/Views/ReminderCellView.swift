//
//  ReminderCellView.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

enum ReminderCellEvents {
    case onInfo
    case onCheckedChanged(Reminder, Bool)
    case onSelect(Reminder)
    
}

struct ReminderCellView: View {
    
    @State private var checked: Bool = false
    let isSelected: Bool
    
    let reminder: Reminder
    let delay: Delay = Delay()
    let onEvent: (ReminderCellEvents) -> Void
    
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.circle.fill" :"circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
                    
                    // Cancel the old task
                    delay.cancel()
                    
                    // call on checked inside the delay
                    delay.performWork {
                        onEvent(.onCheckedChanged(reminder, checked))
                    }
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .opacity(0.4)
            }
            
            Spacer()
            
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0 : 0.0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .onAppear {
            checked = reminder.isCompleted
        }
        .contentShape(Rectangle())
            .onTapGesture {
                onEvent(.onSelect(reminder))
            }
    }
}


#Preview {
    ReminderCellView(
        isSelected: false, reminder: PreviewData.reminder,
        onEvent: {_ in },
    )
}
