//
//  ToDoListView.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//
import UIKit

protocol ToDoListViewProtocol : AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
    func confiSuperView()
}

final class ToDoListView: UIViewController {
    var presenter: ToDoListPresenterProtocol?
    var toDoListTableView: UITableView?
    var titleLabel: UILabel!
    var searchTextField: SearchTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTitleLabel()
        confiSuperView()
        configSearcTextField()
    }
}

extension ToDoListView: ToDoListViewProtocol {
    func confiSuperView(){
        self.view.backgroundColor = .black
    }
    func configTitleLabel(){
        let label = UILabel()
        label.text = "Задачи"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 41)
        label.sizeToFit()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(18)
        }
        titleLabel = label
    }
    func configSearcTextField(){
        let textField = SearchTextField()
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(3)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(36)
        }
        searchTextField = textField
    }
    func configTableView(){
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            
        }
        toDoListTableView = tableView
    }
    
}

extension ToDoListView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(frame: .zero)
    }
}

extension ToDoListView: UITableViewDelegate{
    
}
