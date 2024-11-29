//
//  MockToDoListModule.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 29.11.2024.
//

import Foundation


class MockAPIManager: APIManagerProtocol {
    func fetchTasks(completion: @escaping (Result<[Task], Error>) -> Void) {
        return
    }
    
}

class MockStorageManager: StorageManager {
    var taskList: [TaskCellModel] = []
    var selectedIndex: Int?

    override func getTaskList() -> [TaskCellModel] {
        return taskList
    }


    override func removeTaskAt(index: Int) {
        taskList.remove(at: index)
    }

    override func saveSelectedIndex(_ index: Int) {
        selectedIndex = index
    }

    override func getSelectedIndex() -> Int? {
        return selectedIndex
    }

    override func removeSelectedIndex() {
        selectedIndex = nil
    }
}

class MockVoiceInputManager: VoiceInputManager {
    var isRecording = false
    var didStartRecording = false
    var didFinishRecording = false

    override func startSpeechRecognition(completion: @escaping (String?) -> Void) {
        didStartRecording = true
        completion("Test Speech")
    }

    override func stopSpeechRecognition() {
        didFinishRecording = true
    }
}
