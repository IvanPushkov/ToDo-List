
import UIKit

protocol ToDoListRouterProtocol : AnyObject{
    var viewController: UIViewController? { get set }
    func toTaskView()
}

final class ToDoListRouter: ToDoListRouterProtocol {
    var viewController: UIViewController?
    func toTaskView(){
        viewController?.navigationController?.pushViewController(TaskBuilder.build(), animated: true)
    }
}

