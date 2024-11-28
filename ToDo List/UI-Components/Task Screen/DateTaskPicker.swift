//
//  DateTaskPicker.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 28.11.2024.
//

import UIKit

class DateTaskPicker: UIDatePicker {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPicker()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPicker(){
        self.datePickerMode = .date
        self.minimumDate = .now
        self.preferredDatePickerStyle = .wheels
        self.maximumDate = .distantFuture
    }
}
