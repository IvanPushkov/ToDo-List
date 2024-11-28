//
//  TaskCellModel.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import Foundation

class TaskCellModel: CellModellProtocol{
    var title: String?
    var description: String?
    var date: Date?
    var status: Status?
    
    init(title: String?, description: String?, date: Date?, status: Status?) {
        self.title = title
        self.description = description
        self.date = date
        self.status = status
    }
    func formateDate() -> String{
       let formater = DateFormatter()
       formater.dateFormat = "MM/dd/yy"
        let stringDate = formater.string(from: date ?? .now ) 
       return stringDate
   }
    func changeStatus() {
        if status == .done{
            status = .notDone
        } else{
            status = .done
        }
    }
}
