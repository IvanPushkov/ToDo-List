//  
//  TaskInteractor.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import Foundation


protocol TaskInteractorProtocol : AnyObject{
    var presenter: TaskPresenterProtocol? { get set }
}

final class TaskInteractor: TaskInteractorProtocol {
    weak var presenter: TaskPresenterProtocol?
}
