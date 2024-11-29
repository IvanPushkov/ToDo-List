
import XCTest
@testable import ToDo_List


class ToDoListInteractorTests: XCTestCase {
    var interactor: ToDoListInteractor!
    var mockStorageManager: MockStorageManager!
    var mockVoiceManager: MockVoiceInputManager!
    var mockAPIManager: MockAPIManager!

    override func setUp() {
        super.setUp()
        interactor = ToDoListInteractor()
        mockStorageManager = MockStorageManager()
        mockVoiceManager = MockVoiceInputManager()
        mockAPIManager = MockAPIManager()

    }

    override func tearDown() {
        interactor = nil
        mockStorageManager = nil
        mockVoiceManager = nil
        mockAPIManager = nil
        super.tearDown()
    }

  
   

}

