//
//  MyListDetailView.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

struct MyListDetailView: View {
    
    let myList: MyList
    
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    
    // This is a reads-only property
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    init(myList: MyList) {
        self.myList = myList
        
        // This property gets automatically generated, and can be written to
        _reminderResults = FetchRequest(
            fetchRequest: ReminderService.getRemindersByList(myList)
        )
    }
    
    var body: some View {
        VStack {
            // Display List of Reminders
            ReminderListView(reminders: reminderResults)
            
            // Add Reminder Trigger
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }.alert("New Reminder", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {
                // Discard the current input
            }
            Button("Done") {
                // Save the reminder to My List
                do {
                    try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
                } catch {
                    print(error.localizedDescription)
                }
                
                title = ""
            }.disabled(!isFormValid)
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
