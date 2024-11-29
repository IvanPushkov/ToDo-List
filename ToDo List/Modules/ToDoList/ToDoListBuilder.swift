
import UIKit

final class ToDoListBuilder {
    
    static func build() -> UIViewController {
        let view = ToDoListView()
        let interactor = ToDoListInteractor()
        let router = ToDoListRouter()
        let presenter = ToDoListPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.presenter = presenter
        router.viewController = view
        return view
    }
}
