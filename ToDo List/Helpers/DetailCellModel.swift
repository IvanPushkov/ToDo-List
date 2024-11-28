//
//  detailCellModel.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 28.11.2024.
//

import UIKit

enum TypeDetailModel: Int {
    case title = 0
    case date = 1
    case description = 2
}
enum DetailCellColor{
    case gray
    case white
}



protocol DetailCellModelProtocol{
    var text: String? {get set}
    var isBold: Bool {get set}
    var textHeight: CGFloat {get set}
    var textColor: DetailCellColor {get set}
    var cellHeight: CGFloat {get set}
}

struct DetailCellModel: DetailCellModelProtocol{
    var text: String?
    var isBold: Bool
    var textHeight: CGFloat
    var textColor: DetailCellColor
    var cellHeight: CGFloat
}


class DetailCellModelFactory{
    var taskCellModel: TaskCellModel
    init(taskCellModel: TaskCellModel){
        self.taskCellModel = taskCellModel
    }
    func getDetailCellModelForIndex(_  index: Int) -> DetailCellModelProtocol{
        switch index{
        case 0:
            return DetailCellModel(text: taskCellModel.title, isBold: true, textHeight: 40, textColor: .white, cellHeight: 60)
        case 1:
            return DetailCellModel(text: taskCellModel.formateDate(), isBold: false, textHeight: 16, textColor: .gray, cellHeight: 40)
        case 2:
            return DetailCellModel(text: taskCellModel.description, isBold: false, textHeight: 22, textColor: .white, cellHeight: 100)
        default:
           return DetailCellModel(isBold: true, textHeight: 22, textColor: .gray, cellHeight: 22)
        }
    }
}
