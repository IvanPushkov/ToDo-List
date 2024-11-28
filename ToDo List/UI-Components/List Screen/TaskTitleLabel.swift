//
//  TaskTitleLabel.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import UIKit

final class TaskTitleLabel: UILabel {
    
     init() {
         super.init(frame: .zero)
         config()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        self.text = "Задачи"
        self.textColor = .white
        self.font = UIFont.boldSystemFont(ofSize: 41)
        self.sizeToFit()
    }
}
