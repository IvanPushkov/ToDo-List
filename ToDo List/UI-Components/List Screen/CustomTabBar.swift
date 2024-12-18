//
//  CustomTabBar.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 25.11.2024.
//

import UIKit
import SnapKit

protocol TabBarProtocol{
    func updateText()
}


final class CustomTabBar: UITabBarController {
    var presenter: ToDoListPresenterProtocol?
    var button = UIButton()
    var titleLabel = UILabel()
   
    override func viewDidLoad() {
        setUpAppereance()
        setUpToNextVCButton()
        setUpTitle()
    }
    override func viewWillAppear(_ animated: Bool) {
        updateText()
        presenter?.viewWillAppear()
        initPresenter()
    }
    func updateText(){
        titleLabel.text = presenter?.getTabBarTitle()
    }
    
    //MARK: - UI
    private func setUpAppereance(){
        self.tabBar.backgroundColor = .searchFieldColor
    }
    private func setUpTitle(){
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 17)
        title.textColor = .white
        title.textAlignment = .center
        self.tabBar.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerX.trailing.leading.equalToSuperview()
            make.bottom.equalTo(tabBar.snp.centerY)
        }
        self.titleLabel = title
    }
    private func setUpToNextVCButton(){
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium, scale: .large)
        button.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .customYelow
        tabBar.bringSubviewToFront(button)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.equalTo(tabBar.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
        }
        button.addTarget(self, action: #selector(touchTabBar), for: .touchUpInside)
    }
 //MARK: - PRESENTER METHODS
    func initPresenter(){
        if let vc = (self.selectedViewController as? ToDoListViewProtocol){
            presenter = vc.presenter
        }
    }
    
     @objc private func touchTabBar(){
         presenter?.tabBarWasTouched()
    }
   
}
