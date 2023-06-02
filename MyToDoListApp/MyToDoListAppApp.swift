//
//  MyToDoListAppApp.swift
//  MyToDoListApp
//
//  Created by Lori Rothermel on 5/31/23.
//

import SwiftUI

@main
struct MyToDoListAppApp: App {
    @StateObject var toDosVM = ToDosViewModel()
    
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .environmentObject(toDosVM)
        }
    }
}
