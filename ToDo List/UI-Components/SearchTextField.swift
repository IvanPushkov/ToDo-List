//
//  SearchTextField.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import UIKit

final class SearchTextField: UITextField {

     init(){
         super.init(frame: .zero)
         configTextField()
         setPlaceHolder()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configTextField(){
        setLeftView()
        changeBackGround()
        setPlaceHolder()
    }
    private func setLeftView(){
        self.leftView = getSearchView()
        self.leftViewMode = .always
    }
    private func getSearchView() -> UIImageView{
        guard let image = UIImage(systemName: "magnifyingglass")else {
            return UIImageView()
        }
        let searchView  = UIImageView(image: image)
        searchView.tintColor = .gray
        searchView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        searchView.contentMode = .scaleAspectFit
        return searchView
    }
    private func setPlaceHolder(){
        self.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    private func changeBackGround(){
        self.layer.cornerRadius = 10
        self.backgroundColor = .clear
    }
   
   
}
