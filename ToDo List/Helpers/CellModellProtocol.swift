

import Foundation

enum Status: String{
    case done = "done"
    case notDone = "notDone"
}

protocol CellModellProtocol{
    var title: String? {get set}
    var description: String?  {get set}
    var date: Date? {get set}
    var status: Status? {get set}
    
    func changeStatus()
}
