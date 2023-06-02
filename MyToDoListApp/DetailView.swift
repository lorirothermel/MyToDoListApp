//
//  DetailView.swift
//  MyToDoListApp
//
//  Created by Lori Rothermel on 5/31/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var toDosVM: ToDosViewModel
    @State var toDo: ToDo
    
       
    var body: some View {
        
        List {
            TextField("Enter ToDo Here", text: $toDo.item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            Toggle("Set Reminder", isOn: $toDo.reminderIsOn)
                .padding(.top)
                .listRowSeparator(.hidden)
            DatePicker("Date:", selection: $toDo.dueDate)
                .disabled(!toDo.reminderIsOn)
                .listRowSeparator(.hidden)
                .padding(.bottom)
            Text("Notes:")
                .padding(.top)
                .listRowSeparator(.hidden)
            TextField("Notes", text: $toDo.notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .listRowSeparator(.hidden)
            Toggle("Completed?", isOn: $toDo.isCompleted)
                .listRowSeparator(.hidden)
                .padding(.top)
        }  // List
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }  // Button
            }  // ToolbarItem - Cancel
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    toDosVM.saveToDo(toDo: toDo)
                    dismiss()
                }  // Button
            }  // ToolbarItem - Cancel
        }  // .toolbar
        
        
    }  // some View
}  // DetailView

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(toDo: ToDo())
                .environmentObject(ToDosViewModel())
        }
    }
}
