//  
//  TaskView.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import Foundation
import UIKit

struct TaskViewControllerViewModel {
    
}


protocol TaskViewProtocol : AnyObject {
    var presenter: TaskPresenterProtocol? { get set }
    
    func configure(with viewModel: TaskViewControllerViewModel)
}

final class TaskView: UIViewController {
    var presenter: TaskPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TaskView: TaskViewProtocol {
    func configure(with viewModel: TaskViewControllerViewModel) {
        
    }
}
