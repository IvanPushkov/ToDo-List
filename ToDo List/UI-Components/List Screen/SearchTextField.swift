//
//  SearchTextField.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import UIKit

final class SearchTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
    var micropHoneButton = MicroPhoneButton()
    
    init(){
        super.init(frame: .zero)
        configTextField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 7
        return rect
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
       var newRect = super.rightViewRect(forBounds: bounds)
        newRect.origin.x -= 7
        return newRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    private func configTextField(){
        setLeftView()
        changeBackGround()
        setPlaceHolder()
        changeText()
    }
    private func setLeftView(){
        self.leftView = getSearchView()
        self.leftViewMode = .always
    }
    private func getSearchView() -> UIImageView{
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 22)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig)
        let searchView  = UIImageView(image: image)
        searchView.tintColor = .searchTextColor
        searchView.contentMode = .scaleAspectFit
        return searchView
    }
   
    
    private func setPlaceHolder(){
        self.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.searchTextColor])
    }
    
    private func changeBackGround(){
        self.layer.cornerRadius = 10
        self.backgroundColor = .searchFieldColor
        self.tintColor = .searchTextColor
    }
    private func changeText(){
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 22)
    }
   
   
}
