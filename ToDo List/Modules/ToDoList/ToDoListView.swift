
import UIKit
import Speech

protocol ToDoListViewProtocol : AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
    func setUpMainView()
    func setUpSearchTextField()
    func setUpTitleLabel()
    func setUpTableView()
    func reloadCellAt(index: [IndexPath])
    func switchMicrophone()
    func checkStatusMicrophone() -> Bool
    func setTextToTextField(_ text: String?)
    func reloadTableView()
}

final class ToDoListView: UIViewController {
    var presenter: ToDoListPresenterProtocol?
    var toDoListTableView: UITableView?
    var titleLabel: TaskTitleLabel!
    var searchTextField: SearchTextField!
    var microPhoneButton = MicroPhoneButton()
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
    }
    func setUpTitleLabel(){
        let label = TaskTitleLabel()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.equalToSuperview().inset(18)
        }
        titleLabel = label
    }
    func setUpSearchTextField(){
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
        searchTextField = textField
    }
    @objc func textWasEntered(){
        presenter?.textWasEntered(searchTextField.text)
    }
    func setUpTableView(){
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
        toDoListTableView = tableView
    }
    
    @objc func microPhoneTouch(){
        presenter?.microPhoneTouch()
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
        toDoListTableView?.reloadData()
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
        if let tableView = toDoListTableView{
            tableView.reloadRows(at: index, with: .automatic)
        }
    }
    
}
