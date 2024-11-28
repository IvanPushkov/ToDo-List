//
//  TaskTableViewCell.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell{
    var statusImageView: UIImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var dateLabel: UILabel!
    var cellTaskModel: TaskCellModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCellWith(_ newCellModel: TaskCellModel){
        cellTaskModel = newCellModel
        let date = newCellModel.formateDate()
        dateLabel.text = date
        descriptionLabel.text = newCellModel.description
        titleLabel.text = newCellModel.title
        if let image = UIImage(named: newCellModel.status!.rawValue){
            statusImageView.image = image
        }
        setStyleFor(newCellModel.status!)
    }
    
    private func setStyleFor(_ status: Status){
        switch status{
        case .done:
            setDoneStyleWith(color: .searchTextColor)
        case .notDone:
            setNotDoneStyle()
        }
    }
    private func setNotDoneStyle(){
        titleLabel.attributedText = NSAttributedString(string: cellTaskModel?.title ?? "")
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.textColor = .white
        descriptionLabel.textColor = .white
    }
    private func setDoneStyleWith(color: UIColor){
        let textAtribute = NSAttributedString(string: cellTaskModel?.title ?? "", attributes: [
            .strikethroughColor : color,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue                                                          ])
        titleLabel.attributedText = textAtribute
        titleLabel.textColor = color
        descriptionLabel.textColor = color
    }
    
    private func getStatusImageView() -> UIImageView{
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(12)
            make.size.equalTo(24)
        }
        return imageView
    }
    private func getTitleLabel() -> UILabel{
        let label = UILabel()
        contentView.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 22)
        label.snp.makeConstraints { make in
            make.leading.equalTo(statusImageView.snp.trailing).inset(-5)
            make.trailing.equalToSuperview().inset(40)
            make.centerY.equalTo(statusImageView)
        }
        return label
    }
    private func getDescriptionLabel() -> UILabel{
        let label = UILabel()
        contentView.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.snp.makeConstraints { make in
            make.trailing.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        label.numberOfLines = 2
        label.lineBreakStrategy = .hangulWordPriority
        return label
    }
    
    private func getDateLabel() -> UILabel{
        let label = UILabel()
        contentView.addSubview(label)
        label.textColor = .searchTextColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.snp.makeConstraints { make in
            make.trailing.leading.equalTo(titleLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
        }
        return label
    }
    
    private func setContentView(){
        self.contentView.backgroundColor = .black
    }
    private func configCell(){
        setContentView()
        statusImageView = getStatusImageView()
        titleLabel = getTitleLabel()
        descriptionLabel = getDescriptionLabel()
        dateLabel = getDateLabel()
    }
}
