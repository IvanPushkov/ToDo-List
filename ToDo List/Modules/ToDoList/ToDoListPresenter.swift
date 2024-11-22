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
}

final class ToDoListPresenter: ToDoListPresenterProtocol {
    weak var view: ToDoListViewProtocol?
    var router: ToDoListRouterProtocol?
    var interactor: ToDoListInteractorProtocol?
}
