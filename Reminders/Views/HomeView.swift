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
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
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
            // .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Reminders")
        }.searchable(text: $search)
        
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
