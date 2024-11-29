
import Foundation

class TaskManager {
   static let shared = TaskManager()
    
    func loadTasks(completion: @escaping () -> Void) {
        APIManager.shared.fetchTasks { tasks in
            switch tasks{
            case.success(let tasks):
                let taskModels = self.convertToLocalTask(tasks: tasks)
                CoreDataStack.shared.saveTasks(taskModels)
                DispatchQueue.main.async {
                               completion()
                           }
            case.failure(_):
                print ("error Of LoadingTasks")
            }
        }
    }
    private   func convertToLocalTask(tasks:[Task]) -> [TaskCellModel]{
        var taskCellModels = [TaskCellModel]()
        for task in tasks{
            var status: Status
            if task.completed{
                status = .done
            } else{status = .notDone}
            let taskCellModel = TaskCellModel(title: task.todo,
                                              description: nil,
                                              date: .now,
                                              status: status)
            taskCellModels.append(taskCellModel)
        }
        return taskCellModels
    }
}
