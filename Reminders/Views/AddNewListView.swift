//
//  AddNewListView.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import SwiftUI

struct AddNewListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var selectedColor: Color = .yellow
    
    let onSave: (String, UIColor) -> Void
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundColor(selectedColor)
                    .font(.system(size: 100))
                
                TextField("List name", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(30)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous,
                )
            )
            
            ColorPickerView(selectedColor: $selectedColor)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New List")
                    .font(.headline)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    // Dismiss the view 
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    // Save the list
                    onSave(name, UIColor(selectedColor))
                    // Dismiss the view
                    dismiss()
                }.disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationView {
        AddNewListView { _, _ in
            //
        }
    }
}
