//
//  StorageManagerTest.swift
//  ToDo ListTests
//
//  Created by Ivan Pushkov on 04.12.2024.
//

import XCTest
@testable import ToDo_List

class StorageManagerTests: XCTestCase {
    
    var storageManager: StorageManager!
    var mockCoreDataStack: MockCoreDataStack!
    
    override func setUp() {
        super.setUp()
        
        mockCoreDataStack = MockCoreDataStack()
        storageManager = StorageManager(coreDataStack: mockCoreDataStack)
        
        
    }
    
    override func tearDown() {
        storageManager = nil
        mockCoreDataStack = nil
        super.tearDown()
    }
    
    func testSaveNewTask() {
        // Создаем тестовую задачу
        let task = TaskCellModel(title: "Test Task", description: "Task Description", date: Date(), status: .notDone)
        
        // Вызываем метод сохранения задачи
        storageManager.saveNewTask(newTask: task)
        
        // Проверяем, что задача была добавлена в storage
        XCTAssertEqual(storageManager.getTaskList().count, 1)
        XCTAssertEqual(storageManager.getTaskList().first?.title, "Test Task")
    }
    
    func testChangeTaskAt() {
        // Создаем тестовую задачу
        let task = TaskCellModel(title: "Test Task", description: "Task Description", date: Date(), status: .notDone)
        storageManager.saveNewTask(newTask: task)
        
        // Создаем новую задачу для замены
        let updatedTask = TaskCellModel(title: "Updated Task", description: "Updated Description", date: Date(), status: .done)
        
        // Вызываем метод изменения задачи
        storageManager.changeTaskAt(0, newTask: updatedTask)
        
        // Проверяем, что задача была обновлена
        XCTAssertEqual(storageManager.getTaskList().first?.title, "Updated Task")
        XCTAssertEqual(storageManager.getTaskList().first?.status, .done)
    }
    
    func testRemoveTaskAt() {
        // Создаем тестовую задачу
        let task = TaskCellModel(title: "Test Task", description: "Task Description", date: Date(), status: .notDone)
        storageManager.saveNewTask(newTask: task)
        
        // Проверяем, что задача была добавлена
        XCTAssertEqual(storageManager.getTaskList().count, 1)
        
        // Удаляем задачу
        storageManager.removeTaskAt(index: 0)
        
        // Проверяем, что задача была удалена
        XCTAssertEqual(storageManager.getTaskList().count, 0)
    }
    
    func testGetIndexOf() {
        // Создаем тестовую задачу
        let task = TaskCellModel(title: "Test Task", description: "Task Description", date: Date(), status: .notDone)
        storageManager.saveNewTask(newTask: task)
        
        // Проверяем индекс задачи
        let index = storageManager.getIndexOf(task)
        XCTAssertEqual(index, 0, "Index should be 0 for the first task.")
    }
    
    func testSaveSelectedIndex() {
        // Сохраняем индекс выбранной задачи
        storageManager.saveSelectedIndex(2)
        
        // Проверяем, что индекс сохранен
        XCTAssertEqual(storageManager.getSelectedIndex(), 2)
    }
    
    func testRemoveSelectedIndex() {
        // Сохраняем индекс выбранной задачи
        storageManager.saveSelectedIndex(3)
        
        // Удаляем сохранённый индекс
        storageManager.removeSelectedIndex()
        
        // Проверяем, что индекс удален
        XCTAssertNil(storageManager.getSelectedIndex())
    }
    func testGetSelectedUnExistedIndex(){
        let unexistedCellModel = TaskCellModel(title: "k", description: nil, date: nil, status: .notDone)
        
        let result = storageManager.getIndexOf(unexistedCellModel)
        XCTAssertNil(result)
    }
}
