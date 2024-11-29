
import Foundation
import Alamofire

struct Task: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

struct TasksResponse: Codable {
    let todos: [Task]
    let total: Int
    let skip: Int
    let limit: Int
}

protocol APIManagerProtocol {
    func fetchTasks(completion: @escaping (Result<[Task], Error>) -> Void)
}

class APIManager: APIManagerProtocol {
    static let shared = APIManager()
    private let baseURL = "https://dummyjson.com/todos"
    
    func fetchTasks(completion: @escaping (Result<[Task], Error>) -> Void) {
        AF.request(baseURL, method: .get).responseDecodable(of: TasksResponse.self) { response in
            switch response.result {
            case .success(let tasksResponse):
                completion(.success(tasksResponse.todos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
