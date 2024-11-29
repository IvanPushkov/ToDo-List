//  
//  TaskPresenter.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import Foundation

protocol TaskPresenterProtocol : AnyObject {
    var view: TaskViewProtocol? { get set }
    var router: TaskRouterProtocol? { get set }
    var interactor: TaskInteractorProtocol? { get set }
    func getTaskModel() -> TaskCellModel
    func setUpTaskView()
    func setPickerForCellWith(_ indexPath: IndexPath) -> Bool
    func getNumberOfRowsInSection()-> Int
    func finishEditingTextView(withIndex index: Int)
    func wasChooseDate(_ date: Date)
    func backButtonTouch()
}

final class TaskPresenter: TaskPresenterProtocol {
    weak var view: TaskViewProtocol?
    var router: TaskRouterProtocol?
    var interactor: TaskInteractorProtocol?
    
    func getTaskModel() -> TaskCellModel{
        (interactor?.getCorentTaskModel())!
    }
    func setUpTaskView(){
        view?.configTableView()
    }
    func getNumberOfRowsInSection()-> Int{
        return 3
    }
    func setPickerForCellWith(_ indexPath: IndexPath) -> Bool{
        if indexPath.row == 1{
            return true
        }
        return false
    }
    func finishEditingTextView(withIndex index: Int){
        if index != 1{
            let indexPath = IndexPath(row: index, section: 0)
            let text = view!.getTextFromCellWith(indexPath)
            let type = view!.getTypeFromCellWith(indexPath)
            interactor?.correctDetailFor(type: type, with: text)
        }
    }
    func wasChooseDate(_ date: Date){
        interactor?.saveDate(date)
        let newStringDate = Date.formateDate(date: date)
        view?.setNewDate(newStringDate)
        
    }
    func backButtonTouch(){
        interactor?.reloadDateInStorage()
        router?.goToListTask()
    }
}
