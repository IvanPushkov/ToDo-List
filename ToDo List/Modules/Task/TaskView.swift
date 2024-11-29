//  
//  TaskView.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import UIKit



protocol TaskViewProtocol : AnyObject {
    var presenter: TaskPresenterProtocol? { get set }
    func configTableView()
    func getTextFromCellWith(_ indexPath: IndexPath) -> String?
    func getTypeFromCellWith(_ indexPath: IndexPath) -> TypeDetailModel?
    func setNewDate(_ date: String)
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
        presenter?.setUpTaskView()
    }
}


extension TaskView: TaskViewProtocol {
    
    func configTableView(){
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CellWithTextView.self, forCellReuseIdentifier: "Title")
        setBackButton()
    }
    
    @objc func doneButtonTapped(){
        presenter!.wasChooseDate(datePicker.date)
        
    }
    
    func setupPickerInputTextView(_ textView: UITextView){
        textView.inputAccessoryView = toolBar
        textView.inputView = datePicker
    }
    func getTextFromCellWith(_ indexPath: IndexPath) -> String?{
        if let cell =  (tableView.cellForRow(at: indexPath) as? CellWithTextView){
            return cell.textView.text
        }
        return nil
    }
    func getTypeFromCellWith(_ indexPath: IndexPath) -> TypeDetailModel?{
        if let cell =  (tableView.cellForRow(at: indexPath) as? CellWithTextView){
            return cell.cellModel.type
        }
        return nil
    }
    func setNewDate(_ date: String){
        if let cell = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CellWithTextView){
            cell.textView.text = date
            cell.textView.resignFirstResponder()
        }
    }
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter!.getNumberOfRowsInSection()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title") as! CellWithTextView
        cell.textView.delegate = self
        cell.textView.tag = indexPath.row
        let curentTaskModel = presenter!.getTaskModel()
        cell.configCellFromTask(curentTaskModel, index: indexPath.row)
        if presenter!.setPickerForCellWith(indexPath){
            setupPickerInputTextView(cell.textView)
        }
        return cell
    }
    
//MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let textView = (tableView.cellForRow(at: indexPath) as? CellWithTextView)?.textView{
            textView.becomeFirstResponder()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
//MARK: - UITextViewDelegate
extension TaskView: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let point = textView.convert(CGPoint.zero, to: tableView)
        if  (tableView.indexPathForRow(at: point) != nil)
        {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            let nextTag = textView.tag + 1
            if let nextTextView = (tableView.viewWithTag(nextTag) as? UITextView){
                nextTextView.becomeFirstResponder()
                return true
            }
        }
        return true
    }
   
    func textViewDidChangeSelection(_ textView: UITextView) {
        presenter!.finishEditingTextView(withIndex: textView.tag)
    }
    
}
//MARK: - navigationItem
extension TaskView{
    func setBackButton(){
        let backButton = UIButton(type: .system)
        backButton.setTitle("Назад", for: .normal)
        backButton.tintColor = .customYelow
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTouch), for: .touchUpInside)
        backButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func backButtonTouch(){
        presenter?.backButtonTouch()
    }
}
