//  
//  ToDoListPresenter.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import Foundation

protocol ToDoListPresenterProtocol : AnyObject {
    var view: ToDoListViewProtocol? { get set }
    var router: ToDoListRouterProtocol? { get set }
    var interactor: ToDoListInteractorProtocol? { get set }

    func microPhoneTouch()
    func tabBarWasTouched()
    func removeButonWasTouch()
    func editButtonWasTouch()
    func wasTouchToCellAt(_ indexPath: IndexPath)
    
    func getTabBarTitle() -> String
    func getNumberOfRowsinSection() -> Int
    func getCellModelFor(indexPath: IndexPath) -> TaskCellModel
    func updateTaskStatusAt(_ index: Int)
    func setTextToTextField(_ text: String?)
    func textWasEntered(_ text: String?)
    func longTouch(_ longTouchIsBegan: Bool, _ point: CGPoint)
    func viewWillAppear()
    func setUpMainView()
}

final class ToDoListPresenter: ToDoListPresenterProtocol {
    
    weak var view: ToDoListViewProtocol?
    var router: ToDoListRouterProtocol?
    var interactor: ToDoListInteractorProtocol?
  
    func setUpMainView(){
        interactor?.loadTasks()
        view?.setUpMainView()
    }
    func getCellModelFor(indexPath: IndexPath)-> TaskCellModel{
        let index = indexPath.row
        return interactor!.getCellModelAt(index: index)
    }
    func getNumberOfRowsinSection() -> Int {
        (interactor?.getNumberOfrows())!
    }
    
    func getTabBarTitle() -> String {
        return interactor!.getNumberOfTask()
    }
    func tabBarWasTouched(){
        router?.toTaskView()
    }
    func wasTouchToCellAt(_ indexPath: IndexPath){
        let index = indexPath.row
        interactor?.changeStatusCellAt(index: index)
    }
    func updateTaskStatusAt(_ index: Int){
        let indexPath = IndexPath(row: index, section: 0)
        view?.reloadCellAt(index: [indexPath])
    }
    
    func microPhoneTouch(){
        view?.switchMicrophone()
        let isRecording = view?.checkStatusMicrophone()
        interactor?.microphoneActionWith(isRecording!)
    }
    func setTextToTextField(_ text: String?){
        view?.setTextToTextField(text)
    }
    func textWasEntered(_ text: String?){
        interactor?.filterCellModelsWith(text)
        view?.reloadTableView()
    }
    func longTouch(_ longTouchIsBegan: Bool, _ point: CGPoint){
        if longTouchIsBegan{
            if let indexPath = view?.getIndexPathCellAtPoint(point){
                view?.showAlert()
                let index = indexPath.row
                interactor?.saveIndexOfSelectedCell(index)
            }
        }
    }
    func removeButonWasTouch(){
        interactor?.removeCell()
        view?.reloadTableView()
    }
    
    func editButtonWasTouch(){
        router?.toTaskView()
    }
    func viewWillAppear(){
        interactor?.reloadCurentTaskList()
        view?.reloadTableView()
    }
}
