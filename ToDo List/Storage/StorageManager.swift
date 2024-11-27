//
//  StorageManager.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import Foundation

class StorageManager{
   
    private var storage: [TaskCellModel] = [TaskCellModel(title: "task1", description: "You need too clean the door", date: .now, status: .notDone),
                                    TaskCellModel(title: "task2", description: "You shoud too clean the door", date: .now, status: .notDone),
                                    TaskCellModel(title: "task3", description: "You shall too clean the door", date: .now, status: .notDone)]
    
    func saveNewTask(newTask: TaskCellModel){
        
    }
    func getTaskList() -> [TaskCellModel]{
        return storage
    }
    func changeStatusTaskAt(_ index: Int){
        storage[index].changeStatus()
    }
    func getIndexOf(_ model: TaskCellModel) -> Int{
        for (index,storageModel) in storage.enumerated(){
            if model === storageModel{
                return index
            }
        }
        print("Index is not found")
        return 0
    }
}