//  
//  TaskBuilder.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import UIKit

final class TaskBuilder {
    
    static func build() -> UIViewController {
        let view = TaskView()
        let interactor = TaskInteractor()
        let router = TaskRouter()
        let presenter = TaskPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.presenter = presenter
        router.viewController = view
        return view
    }
}
