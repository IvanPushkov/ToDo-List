//  
//  ToDoListRouter.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import UIKit

protocol ToDoListRouterProtocol : AnyObject{
    var viewController: UIViewController? { get set }
}

final class ToDoListRouter: ToDoListRouterProtocol {
    var viewController: UIViewController?
}

