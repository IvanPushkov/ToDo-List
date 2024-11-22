//
//  TaskCellModel.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import Foundation

class TaskCellModel: CellModellProtocol{
    var title: String
    var description: String
    var date: Date
    var status: Status
    
    init(title: String, description: String, date: Date, status: Status) {
        self.title = title
        self.description = description
        self.date = date
        self.status = status
    }
}
