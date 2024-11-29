
import Foundation


protocol TaskInteractorProtocol : AnyObject{
    var presenter: TaskPresenterProtocol? { get set }
    func getCorentTaskModel() -> TaskCellModel
    func correctDetailFor(type: TypeDetailModel?, with text: String?)
    func saveDate(_ date: Date)
    func reloadDateInStorage()
}

final class TaskInteractor: TaskInteractorProtocol {
    weak var presenter: TaskPresenterProtocol?
    var storageManager = StorageManager.shared
    private lazy var curentTaskCellModel: TaskCellModel = getCorentTaskModel()
    func getCorentTaskModel() -> TaskCellModel{
        for (index, model) in storageManager.getTaskList().enumerated(){
            if index == storageManager.getSelectedIndex(){
                return model
            }
        }
        return TaskCellModel(title: nil, description: nil, date: nil, status: .notDone)
    }
    func correctDetailFor(type: TypeDetailModel?, with text: String?){
        switch type{
        case .title:
            curentTaskCellModel.title = text
        case .description:
            curentTaskCellModel.description = text
        case .date: break
        case .none:
            break
        }
    }
    func saveDate(_ date: Date){
        curentTaskCellModel.date = date
    }
    func reloadDateInStorage(){
        if let editCellIndex = storageManager.getSelectedIndex(){
            storageManager.changeTaskAt(editCellIndex, newTask: curentTaskCellModel)
        } else{
            storageManager.saveNewTask(newTask: curentTaskCellModel)
        }
        storageManager.removeSelectedIndex()
    }
   
}
