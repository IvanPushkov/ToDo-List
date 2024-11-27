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
    // output
    func microPhoneTouch()
    func viewIsReadyToSetUp()
    func tabBarWasTouched()
    // input
    func getTabBarTitle() -> String
    func getNumberOfRowsinSection() -> Int
    func getCellModelFor(indexPath: IndexPath) -> TaskCellModel
    func wasTouchToCellAt(_ indexPath: IndexPath)
    func updateTaskStatusAt(_ index: Int)
    func setTextToTextField(_ text: String?)
    func textWasEntered(_ text: String?)
}

final class ToDoListPresenter: ToDoListPresenterProtocol {
    
    
    weak var view: ToDoListViewProtocol?
    var router: ToDoListRouterProtocol?
    var interactor: ToDoListInteractorProtocol?
    func viewIsReadyToSetUp(){
        view?.setUpMainView()
        view?.setUpTitleLabel()
        view?.setUpSearchTextField()
        view?.setUpTableView()
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
}
