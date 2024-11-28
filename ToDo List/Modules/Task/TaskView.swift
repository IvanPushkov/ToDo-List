//  
//  TaskView.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import UIKit



protocol TaskViewProtocol : AnyObject {
    var presenter: TaskPresenterProtocol? { get set }
}

final class TaskView: UITableViewController {
    var presenter: TaskPresenterProtocol?
    private var datePicker = DateTaskPicker()
    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNewCells()
        configTableView()
    }
    
    @objc func doneButtonTapped(){
        print(datePicker.date)
    }
    

}


extension TaskView: TaskViewProtocol {
    
    func registerNewCells(){
        tableView.register(CellWithTextView.self, forCellReuseIdentifier: "Title")
    }
    func configTableView(){
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.rowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title") as! CellWithTextView
        cell.textView.delegate = self
        cell.textView.tag = indexPath.row
        cell.configCellFromTask((presenter?.getTaskModel())!, index: indexPath.row)
        if indexPath.row == 1{
            setupPickerInputTextView(cell.textView)
        }
        return cell
    }
    
    func setupPickerInputTextView(_ textView: UITextView){
        textView.inputAccessoryView = toolBar
        textView.inputView = datePicker
    }

    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let textView = (tableView.cellForRow(at: indexPath) as? CellWithTextView)?.textView{
            textView.becomeFirstResponder()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if indexPath.row == 1{
            return 50
        }
        return UITableView.automaticDimension // Для остальных — динамическая высота
    }
    
    func reloadCellAt(index: [IndexPath]){
    //    toDoListTableView.reloadRows(at: index, with: .automatic)
    }
    
    
}

extension TaskView: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let point = textView.convert(CGPoint.zero, to: tableView)
               if let indexPath = tableView.indexPathForRow(at: point){
                   tableView.beginUpdates()
                   tableView.endUpdates()
               }
           }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            let nextTag = textView.tag + 1
            if let nextTextView = (tableView.viewWithTag(nextTag) as? UITextView)   {
                nextTextView.becomeFirstResponder() // Передаём фокус следующему UITextView
            } else {
                textView.resignFirstResponder() // Убираем клавиатуру, если это последняя ячейка
            }
            return false // Возвращаем false, чтобы скрыть стандартное поведение Return
        }
        return true
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.tag == 1{
            return true
        }
        return true
    }
}
