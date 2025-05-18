//
//  ContentView.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPresented: Bool = false
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            VStack {
                
                MyListView(myLists: myListResults)
                
//                Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }.sheet(isPresented: $isPresented) {
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
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
