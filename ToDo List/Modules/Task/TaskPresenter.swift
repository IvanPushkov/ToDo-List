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
}

final class TaskPresenter: TaskPresenterProtocol {
    weak var view: TaskViewProtocol?
    var router: TaskRouterProtocol?
    var interactor: TaskInteractorProtocol?
}
