//
//  Extension Date.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 29.11.2024.
//

import UIKit

extension  Date{
    static func formateDate(date: Date?) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "MM/dd/yy"
        let stringDate = formater.string(from: date ?? .now )
        return stringDate
    }
}
