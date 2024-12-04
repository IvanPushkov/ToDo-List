//
//  VoiceInputManagerMock.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 04.12.2024.
//

import Foundation


class MockVoiceInputManager: VoiceInputManaging {
    var checkRecordRequestsCalled = false
    var startSpeechRecognitionCalled = false
    var stopSpeechRecognitionCalled = false
    var mockAuthorizationStatus: Bool = true
    var mockSpeechRecognitionAvailability: Bool = true
    
    // Мок для checkRecordRequests
    func checkRecordRequests(completion: @escaping (Bool) -> Void) {
        checkRecordRequestsCalled = true
        
        // Эмулируем доступность распознавания речи и микрофона
        if mockSpeechRecognitionAvailability {
            completion(mockAuthorizationStatus)
        } else {
            completion(false)
        }
    }
    
    // Мок для startSpeechRecognition
    func startSpeechRecognition(completion: @escaping (String?) -> Void) {
        startSpeechRecognitionCalled = true
        
        // Возвращаем результат как в реальной работе
        if mockSpeechRecognitionAvailability {
            completion("Распознанный текст")
        } else {
            completion(nil)
        }
    }
    
    // Мок для stopSpeechRecognition
    func stopSpeechRecognition() {
        stopSpeechRecognitionCalled = true
    }
}
