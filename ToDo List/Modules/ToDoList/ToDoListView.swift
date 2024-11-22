//
//  ToDoListView.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//
import UIKit

protocol ToDoListViewProtocol : AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
}

final class ToDoListView: UIViewController {
    var presenter: ToDoListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ToDoListView: ToDoListViewProtocol {
  
}
