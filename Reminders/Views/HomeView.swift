//
//  ContentView.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPresented: Bool = false
    @State private var searching: Bool = false
    @State private var search: String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.today))
    private var todayResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.scheduled))
    private var scheduledResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.all))
    private var allResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.completed))
    private var completedResults: FetchedResults<Reminder>
    
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValue()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack{
                        HStack {
                            NavigationLink {
                                ReminderListView(reminders: todayResults)
                            } label : {
                                ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todayCount)
                            }
                            NavigationLink {
                                ReminderListView(reminders: allResults)
                            } label : {
                                ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount, iconColor: .orange)
                            }
                        }
                        HStack {
                            NavigationLink {
                                ReminderListView(reminders: scheduledResults)
                            } label : {
                                ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatsValues.scheduledCount, iconColor: .secondary)
                            }
                            
                            NavigationLink {
                                ReminderListView(reminders: completedResults)
                            } label : {
                                ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount, iconColor: .primary)
                            }
                        }
                    }
                    
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    MyListView(myLists: myListResults)
                    
                    //                Spacer()
                    
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }.padding()
                }
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        // Save the list into the database
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                        
                    }
                }
            }
            .listStyle(.plain)
            .onChange(of: search, { _, searchTerm in
                searching = !searchTerm.isEmpty
                searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(searchTerm).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults)
                    .opacity(searching ? 1.0 : 0.0)
            })
            .onAppear {
                reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
            }
            .padding()
            .navigationTitle("Reminders")
        }.searchable(text: $search)
        
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
