import Foundation
import Speech
import AVFoundation

protocol VoiceInputManaging {
    func checkRecordRequests(completion: @escaping (Bool) -> Void)
    func startSpeechRecognition(completion: @escaping (String?) -> Void)
    func stopSpeechRecognition()
}
class VoiceInputManager: VoiceInputManaging {

    private let audioEngine = AVAudioEngine()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer()
    private let request = SFSpeechAudioBufferRecognitionRequest()

    // Проверка доступности микрофона и распознавания
    func checkRecordRequests(completion: @escaping (Bool) -> Void) {
        requestSpeechRecognitionAuthorization { isSpeechAvailable in
            if isSpeechAvailable {
                self.requestMicrophoneAuthorization { isMicAvailable in
                    completion(isMicAvailable)
                }
            } else {
                completion(false)
                print("Распознавание речи недоступно")
            }
        }
    }

    // Запрос разрешения на распознавание речи
   private func requestSpeechRecognitionAuthorization(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    print("Доступ к распознаванию речи предоставлен")
                    completion(true)
                case .denied:
                    print("Доступ к распознаванию речи запрещён")
                    completion(false)
                case .restricted:
                    print("Распознавание речи недоступно на этом устройстве")
                    completion(false)
                case .notDetermined:
                    print("Пользователь ещё не дал разрешение")
                    completion(false)
                @unknown default:
                    completion(false)
                }
            }
        }
    }

    // Запрос разрешения на использование микрофона
   private func requestMicrophoneAuthorization(completion: @escaping (Bool) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                if granted {
                    print("Доступ к микрофону предоставлен")
                    completion(true)
                } else {
                    print("Доступ к микрофону запрещён")
                    completion(false)
                }
            }
        }
    }

    // Начать распознавание речи
    func startSpeechRecognition(completion: @escaping (String?) -> Void) {
        guard let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
            print("Распознавание речи недоступно")
            completion(nil)
            return
        }

        do {
            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.request.append(buffer)
            }

            audioEngine.prepare()
            try audioEngine.start()

            recognitionTask = speechRecognizer.recognitionTask(with: request) { result, error in
                if let error = error {
                    print("Ошибка распознавания речи: \(error.localizedDescription)")
                    completion(nil)
                    self.stopSpeechRecognition()
                    return
                }

                if let result = result {
                    let text = result.bestTranscription.formattedString
                    print("Распознан текст: \(text)")
                    completion(text)
                    if result.isFinal {
                        self.stopSpeechRecognition()
                    }
                }
            }

            print("Распознавание речи началось")
        } catch {
            print("Ошибка запуска аудиосистемы: \(error.localizedDescription)")
            completion(nil)
            stopSpeechRecognition()
        }
    }

    // Остановить распознавание речи
    func stopSpeechRecognition() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
        recognitionTask = nil
        print("Распознавание речи завершено")
    }
}
