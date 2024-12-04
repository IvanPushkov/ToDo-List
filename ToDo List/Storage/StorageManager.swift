

import Foundation
import CoreData

protocol StorageManagerForToDoList{
    func saveNewTask(newTask: TaskCellModel) -> Void
    func changeTaskAt(_ index: Int, newTask: TaskCellModel)-> Void
    func removeTaskAt(index: Int)
    func loadTasks()
    func getTaskList() -> [TaskCellModel]
    func changeStatusTaskAt(_ index: Int)
    func getIndexOf(_ model: TaskCellModel) -> Int?
    func saveSelectedIndex(_ index: Int)
    func getSelectedIndex() -> Int?
    func removeSelectedIndex()
}


class StorageManager: StorageManagerForToDoList{
    static let shared = StorageManager()
    private var savedIndex: Int?
    private(set) var storage: [TaskCellModel] = []
    private let context = CoreDataStack.shared.context
    private let coreDataSteck: CoreDataStackProtocol
    
    init(coreDataStack: CoreDataStackProtocol = CoreDataStack.shared){
        self.coreDataSteck = coreDataStack
    }
    
    func saveNewTask(newTask: TaskCellModel) {
        let entity = TaskEntity(context: context)
        entity.title = newTask.title
        entity.taskDescription = newTask.description
        entity.date = newTask.date
        entity.isCompleted = newTask.status == .done
        saveContext()
        storage.append(newTask)
    }
    
    private func saveContext(){
        coreDataSteck.saveContext()
    }
    func changeTaskAt(_ index: Int, newTask: TaskCellModel){
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
             if let result = try? context.fetch(fetchRequest), index < result.count {
                 let entity = result[index]
                 entity.title = newTask.title
                 entity.taskDescription = newTask.description
                 entity.date = newTask.date
                 entity.isCompleted = newTask.status == .done
                 saveContext()
                 storage[index] = newTask
             }
    }
    
    func removeTaskAt(index: Int){
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
               if let result = try? context.fetch(fetchRequest), index < result.count {
                   context.delete(result[index])
                   saveContext()

                   storage.remove(at: index)
               }
    }
    func loadTasks() {
            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            if let result = try? context.fetch(fetchRequest) {
                storage = result.map { entity in
                    let status: Status = entity.isCompleted ? .done : .notDone
                    return TaskCellModel(
                        title: entity.title,
                        description: entity.taskDescription,
                        date: entity.date,
                        status: status
                    )
                }
            }
        }
    
    func getTaskList() -> [TaskCellModel]{
        return storage
    }
    func changeStatusTaskAt(_ index: Int){
        storage[index].changeStatus()
    }
    func getIndexOf(_ model: TaskCellModel) -> Int?{
        for (index,storageModel) in storage.enumerated(){
            if model === storageModel{
                return index
            }
        }
        print("Index is not found")
        return nil
    }
    func saveSelectedIndex(_ index: Int){
        savedIndex = index
    }
    func getSelectedIndex() -> Int?{
        return savedIndex
    }
    func removeSelectedIndex(){
        savedIndex = nil
    }
}
