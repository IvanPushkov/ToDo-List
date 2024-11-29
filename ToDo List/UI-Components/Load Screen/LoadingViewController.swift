
import UIKit

class LoadingViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        view.backgroundColor = .systemBackground
        setupActivityIndicator()
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
}
