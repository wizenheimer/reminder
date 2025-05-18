//
//  ReminderDetailView.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                        }
                        
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        
                        Section {
                            NavigationLink {
                                SelectListView(selectedList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }
                        }
                    }
                    .onChange(of: editConfig.hasDate) { _, _ in
                        if editConfig.hasDate {
                            editConfig.reminderDate = Date()
                        }
                    }
                    .onChange(of: editConfig.hasTime) { _, _ in
                        if editConfig.hasTime {
                            editConfig.reminderTime = Date()
                        }
                    }
                }.listStyle(.insetGrouped)
            }.onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        do {
                            let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                            if updated {
                                // Check if we should even schedule a notification
                                if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                    
                                    let userData = UserData(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime)
                                    
                                    NotificationManager.scheduleNotification(userData: userData)
                                }
                            }
                        } catch {
                            print(error)
                        }
                        dismiss()
                    }.disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
