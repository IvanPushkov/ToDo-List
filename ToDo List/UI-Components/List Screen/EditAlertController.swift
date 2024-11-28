import UIKit
//  EditAlertController.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 27.11.2024.
//
final class EditAlertController: UIAlertController {
  
     
    
    func addAlertActionWith(removeAction: @escaping()->(), editAction: @escaping()->() ){
        var editAction = UIAlertAction(title: "Редактировать", style: .default) { _ in
            editAction()
        }
        var removeAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            removeAction()
        }
        editAction.setValue(UIImage(systemName: "square.and.pencil"), forKey: "image")
        removeAction.setValue(UIImage(systemName: "trash.slash"), forKey: "image")
        addAction(editAction)
        addAction(removeAction)
    }
}

