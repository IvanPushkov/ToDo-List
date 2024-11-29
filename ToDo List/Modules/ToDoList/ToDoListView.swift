
import UIKit


protocol ToDoListViewProtocol : AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
    func setUpMainView()
    func reloadCellAt(index: [IndexPath])
    func switchMicrophone()
    func checkStatusMicrophone() -> Bool
    func setTextToTextField(_ text: String?)
    func reloadTableView()
    func getIndexPathCellAtPoint(_ point: CGPoint) -> IndexPath?
    func showAlert()
}

final class ToDoListView: UIViewController {
    var presenter: ToDoListPresenterProtocol?
    
    private lazy var titleLabel: TaskTitleLabel = {
        let label = TaskTitleLabel()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.equalToSuperview().inset(18)
        }
        return label
    }()
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        view.addSubview(textField)
        textField.rightView = microPhoneButton
        textField.rightViewMode = .always
        microPhoneButton.addTarget(self, action: #selector(microPhoneTouch), for: .touchUpInside)
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(30)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(36)
        }
        textField.addTarget(self, action: #selector(textWasEntered), for: .editingChanged)
        return textField
    }()
    
    private lazy var toDoListTableView: UITableView  = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.rowHeight = 106
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "Task")
        tableView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(18)
            make.top.equalTo(searchTextField.snp.bottom).offset(30)
            make.bottom.equalToSuperview().inset(100)
        }
        let longTouchGest = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        tableView.addGestureRecognizer(longTouchGest)
         return tableView
    }()
    private lazy var microPhoneButton = MicroPhoneButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewIsReadyToSetUp()
    }
    
}
//MARK: - ToDoListViewProtocol
extension ToDoListView: ToDoListViewProtocol {
    func setUpMainView(){
        self.dismissKeyboard()
        self.view.backgroundColor = .black
        _ = titleLabel
        _ = searchTextField
        _ = toDoListTableView
    }
    
    func switchMicrophone(){
        microPhoneButton.microphoneSwitch()
    }
    func checkStatusMicrophone() -> Bool{
        microPhoneButton.isRecording
    }
    func setTextToTextField(_ text: String?){
        searchTextField.text = text
    }
    func reloadTableView(){
        toDoListTableView.reloadData()
        
    }
    func showAlert(){
        let editAlert = EditAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        editAlert.addAlertActionWith(removeAction: removeButtonTouch, editAction: editButtonTouch)
        present(editAlert, animated: true)
    }
    private func removeButtonTouch(){
        presenter?.removeButonWasTouch()
    }
    private func editButtonTouch(){
        presenter?.editButtonWasTouch()
    }
    func getIndexPathCellAtPoint(_ point: CGPoint) -> IndexPath?{
     let indexPath = toDoListTableView.indexPathForRow(at: point)
        return indexPath
    }
    
    //MARK: - Objc funcs
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer){
        let longTouchIsBegan = (gesture.state == .began)
        let point = gesture.location(in: toDoListTableView)
        presenter?.longTouch(longTouchIsBegan, point)
    }
    @objc func microPhoneTouch(){
        presenter?.microPhoneTouch()
    }
    @objc func textWasEntered(){
        presenter?.textWasEntered(searchTextField.text)
    }
    
}
//MARK: - UITableViewDataSource
extension ToDoListView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter!.getNumberOfRowsinSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task") as! TaskTableViewCell
        cell.updateCellWith((presenter?.getCellModelFor(indexPath: indexPath))!)
        return cell
    }
    
}
//MARK: - UITableViewDelegate
extension ToDoListView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.wasTouchToCellAt(indexPath)
    }
    
    
    func reloadCellAt(index: [IndexPath]){
        toDoListTableView.reloadRows(at: index, with: .automatic)
    }
    
}
