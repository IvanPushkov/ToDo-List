
import Foundation

class MockStorageManager: StorageManagerForToDoList {
    
    private var taskList: [TaskCellModel] = []
    private var selectedIndex: Int?
    
    // Мокируем метод сохранения новой задачи
    func saveNewTask(newTask: TaskCellModel) {
        taskList.append(newTask)
    }
    
    // Мокируем метод изменения задачи по индексу
    func changeTaskAt(_ index: Int, newTask: TaskCellModel) {
        guard index < taskList.count else { return }
        taskList[index] = newTask
    }
    
    // Мокируем метод удаления задачи по индексу
    func removeTaskAt(index: Int) {
        guard index < taskList.count else { return }
        taskList.remove(at: index)
    }
    
    // Мокируем метод загрузки задач
    func loadTasks() {
        // Просто возвращаем текущий список задач
    }
    
    // Мокируем метод получения списка задач
    func getTaskList() -> [TaskCellModel] {
        return taskList
    }
    
    // Мокируем метод изменения статуса задачи
    func changeStatusTaskAt(_ index: Int) {
        guard index < taskList.count else { return }
        taskList[index].changeStatus()
    }
    
    func getIndexOf(_ model: TaskCellModel) -> Int? {
        if let index = taskList.firstIndex(where: { $0 === model }) {
            return index
        }
        print("Index is not found")
        return nil
    }
    
    // Мокируем метод сохранения выбранного индекса
    func saveSelectedIndex(_ index: Int) {
        selectedIndex = index
    }
    
    // Мокируем метод получения сохраненного индекса
    func getSelectedIndex() -> Int? {
        return selectedIndex
    }
    
    // Мокируем метод удаления сохраненного индекса
    func removeSelectedIndex() {
        selectedIndex = nil
    }
}
