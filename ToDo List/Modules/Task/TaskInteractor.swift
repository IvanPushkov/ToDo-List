//  
//  TaskInteractor.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import Foundation


protocol TaskInteractorProtocol : AnyObject{
    var presenter: TaskPresenterProtocol? { get set }
    func getCorentTaskModel() -> TaskCellModel
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
}
