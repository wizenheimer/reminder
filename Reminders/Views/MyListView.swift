//
//  MyListView.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

struct MyListView: View {
    
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No reminders found")
            } else {
                ForEach(myLists) { myList in
                    VStack {
                        MyListCellView(myList: myList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading], 10)
                            .font(.title3)
                        Divider()
                        
                    }
                }
            }
        }
    }
}

/*
#Preview {
    MyListView()
}
*/
