//  
//  ToDoListInteractor.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import Foundation


protocol ToDoListInteractorProtocol : AnyObject{
    var presenter: ToDoListPresenterProtocol? { get set }
}

final class ToDoListInteractor: ToDoListInteractorProtocol {
    weak var presenter: ToDoListPresenterProtocol?
}
