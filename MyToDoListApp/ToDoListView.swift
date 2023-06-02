//
//  ToDoListView.swift
//  MyToDoListApp
//
//  Created by Lori Rothermel on 5/31/23.
//

import SwiftUI

struct ToDoListView: View {
    @EnvironmentObject var toDosVM: ToDosViewModel
    @State private var sheetIsPresented = false
    @State private var checkmarkIsTapped = false
    
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDosVM.toDos) { toDo in
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDosVM.toggleCompleted(toDo: toDo)
                            }
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }  // NavigationLink
                    }  // HStack
                    .font(.title2)
                }  // ForEach
                // Shorthand for onDelete & onMove
                .onDelete(perform: toDosVM.deleteToDo)
                .onMove(perform: toDosVM.moveToDo)
                
                  // traditional calls below
//                .onDelete { indexSet in
//                    toDosVM.delete(indexSet: indexSet)
//                }  // .onDelete
//                .onMove { fromOffsets, toOffset in
//                    toDosVM.move(fromOffsets: fromOffsets, toOffset: toOffset)
//                }  // .onMove
                
            }  // List
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }  // Button
                }  // ToolbarItem - Plus
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }  // ToolbarItem - Edit
            }  // .toolbar
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(toDo: ToDo())
                }  // NavigationStack
            }  // .sheet
        }  // NavigationStack

    }  // some View
}  // ContentView



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
            .environmentObject(ToDosViewModel())
    }
}


