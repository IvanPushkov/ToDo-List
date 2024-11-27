//  
//  TaskRouter.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import UIKit

protocol TaskRouterProtocol : AnyObject{
    var viewController: UIViewController? { get set }
}

final class TaskRouter: TaskRouterProtocol {
    var viewController: UIViewController?
}

