//
//  ViewControllerHideKeyBoard.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import UIKit

extension UIViewController{
    func setUpDismissalKeyBoard(){
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
    }
 @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

