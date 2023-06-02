//
//  ToDosViewModel.swift
//  MyToDoListApp
//
//  Created by Lori Rothermel on 6/1/23.
//

import Foundation

class ToDosViewModel: ObservableObject {
    @Published var toDos: [ToDo] = []
    
    init() {
        // purgeData() 
        loadData()
    }  // init
    
    func toggleCompleted(toDo: ToDo) {
        // Don't try to update if toDos.id == nil which it never should be. But in case another developer tries to call this in the wrong place it is covered.
        guard toDo.id != nil else { return }
        var newToDo = toDo
        newToDo.isCompleted.toggle()
        
        // Find the ID for the newToDo in the array of toDos then update the element at that index with the data in newToDo
        if let index = toDos.firstIndex(where: {$0.id == newToDo.id}) {
            toDos[index] = newToDo
        }
        saveData()
    }
    
    
    func saveToDo(toDo: ToDo) {
        if toDo.id == nil {
            var newToDo = toDo
            newToDo.id = UUID().uuidString
            toDos.append(newToDo)
        } else {
            if let index = toDos.firstIndex(where: {$0.id == toDo.id}) {
                toDos[index] = toDo
            }  // if let
        }  // if
        saveData()
    }
        
    
    func deleteToDo(indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
        saveData()
    }
    
    
    func moveToDo(fromOffsets: IndexSet, toOffset: Int ) {
        toDos.move(fromOffsets: fromOffsets, toOffset: toOffset)
        saveData()
    }
    
    func saveData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        let data = try? JSONEncoder().encode(toDos)    // try? means if error is thrown data = nil
        do {
            try data?.write(to: path)
        } catch {
            print("❗️ ERROR: Could not save data! \(error.localizedDescription)")
        }  // do...catch
    }  // saveData
    
    func loadData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        guard let data = try? Data(contentsOf: path) else { return }
        do {
            toDos = try JSONDecoder().decode(Array<ToDo>.self, from: data)
        } catch {
            print("❗️ERROR: Could not save data! \(error.localizedDescription)")
        }  // do...catch
    }  // loadData
    
    func purgeData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        let data = try? JSONEncoder().encode("")
        do {
            try data?.write(to: path)
        } catch {
            print("❗️ ERROR: Could not clear out data! \(error.localizedDescription)")
        }  // do...catch
    }  // purgeData
    
    
}
