//
//  TitleTaskCell.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 27.11.2024.
//

import UIKit

class CellWithTextView: UITableViewCell {

    lazy var textView: UITextView = {
       let textView = UITextView()
        textView.isScrollEnabled = false
        contentView.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(3)
            make.leading.trailing.equalToSuperview().inset(3)
        }
        return textView
    }()
    
    var cellModel: DetailCellModel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setBackGround()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackGround(){
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        textView.backgroundColor = .black
        selectionStyle = .none
    }
   
    func configCellFromTask(_ task: TaskCellModel, index: Int){
        let modelFactory = DetailCellModelFactory(taskCellModel: task)
        cellModel = modelFactory.getDetailCellModelForIndex(index) as? DetailCellModel
        textView.font = getFont(isBold: cellModel.isBold, size: cellModel.textHeight)
        textView.textColor = getColorFromModel(color: cellModel.textColor)
        textView.text = cellModel.text
        setCellHeight(cellModel.cellHeight)
    }
    
    private func  getFont(isBold: Bool, size: CGFloat) -> UIFont{
        if isBold{
            return UIFont.boldSystemFont(ofSize: size)
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    private func getColorFromModel(color: DetailCellColor) -> UIColor{
        switch color{
        case .gray:
            return UIColor.gray
        case .white:
            return UIColor.white
        }
    }
    private func setCellHeight(_ height: CGFloat){
        contentView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
   

}
