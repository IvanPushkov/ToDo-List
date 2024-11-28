//  
//  ToDoListInteractor.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import Foundation


protocol ToDoListInteractorProtocol : AnyObject{
    var presenter: ToDoListPresenterProtocol? { get set }
    func getNumberOfrows() -> Int
    func getCellModelAt(index: Int) -> TaskCellModel
    func getNumberOfTask() -> String
    func changeStatusCellAt(index: Int)
    func microphoneActionWith(_ isRecording: Bool)
    func filterCellModelsWith(_ text: String?)
    func saveIndexOfSelectedCell(_ index: Int)
    func removeCell()
    func cleanSelectedTask()
}

final class ToDoListInteractor: ToDoListInteractorProtocol {
    weak var presenter: ToDoListPresenterProtocol?
    let voiceManager = VoiceInputManager()
    var storageManager = StorageManager.shared
    lazy var corentTaskList = self.storageManager.getTaskList()
    //MARK: - Content Settings
    func getNumberOfrows() -> Int{
        corentTaskList.count
    }
    func getCellModelAt(index: Int) -> TaskCellModel{
        return corentTaskList[index]
    }
    func getNumberOfTask() -> String {
        let correctWord = endWord(number: getNumberOfrows())
        return "\(getNumberOfrows()) " + correctWord
    }
    private func endWord(number: Int) -> String{
        let remainder10 = number % 10
            let remainder100 = number % 100
            if remainder100 >= 11 && remainder100 <= 19 {
                return "задач"
            }
            switch remainder10 {
            case 1:
                return "задача"
            case 2, 3, 4:
                return "задачи"
            default:
                return "задач"
            }
    }
    
    func changeStatusCellAt(index: Int) {
        let storageIndex = getOriginIndex(index)
        storageManager.changeStatusTaskAt(storageIndex)
        presenter?.updateTaskStatusAt(index)
    }
    private func getOriginIndex(_ index: Int) -> Int{
        let corentCellModel = corentTaskList[index]
        let storageIndex = storageManager.getIndexOf(corentCellModel)
        return storageIndex
    }
    //MARK: - Alert Settings
    func saveIndexOfSelectedCell(_ index: Int){
        let selectedIndex = getOriginIndex(index)
        storageManager.saveSelectedIndex(selectedIndex)
    }
    func removeCell(){
        storageManager.removeTaskAt(index: storageManager.getSelectedIndex()!)
        corentTaskList = storageManager.getTaskList()
    }
    func cleanSelectedTask(){
        
    }
    
     
   //MARK: - Microphone Settings
    func microphoneActionWith(_ isRecording: Bool){
        isRecording ? startRecord() : finishRecord()
    }
    private func startRecord(){
        voiceManager.checkRecordRequests(){ isAvailable in
            if isAvailable{
                self.voiceManager.startSpeechRecognition(){ text in
                    if let text = text{
                        self.presenter?.setTextToTextField(text)
                    }
                }
            }
        }
    }
    private func finishRecord(){
            self.voiceManager.stopSpeechRecognition()
    }
    //MARK: - Filter Settings
    func filterCellModelsWith(_ text: String?){
        if let text = text, !text.isEmpty{
            corentTaskList = storageManager.getTaskList().filter{ model in
                model.formateDate().range(of: text, options: .caseInsensitive) != nil ||
                model.title?.range(of: text, options: .caseInsensitive) != nil ||
                model.description?.range(of: text, options: .caseInsensitive) != nil
            }
        }
        else{
            corentTaskList = storageManager.getTaskList()
        }
    }
    
}
