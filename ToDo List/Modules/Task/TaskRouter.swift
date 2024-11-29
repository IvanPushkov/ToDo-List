//  
//  TaskRouter.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import UIKit

protocol TaskRouterProtocol : AnyObject{
    var viewController: UIViewController? { get set }
    func goToListTask()
}

final class TaskRouter: TaskRouterProtocol {
    var viewController: UIViewController?
    func goToListTask(){
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}

