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
    var model: TaskCellModel?{
        didSet{
            updateCell()
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateCell(){
        guard let cellModel = model else {
            return
        }
        let date = formate(date: cellModel.date)
        dateLabel.text = date
        descriptionLabel.text = cellModel.description
        titleLabel.text = cellModel.title
        if let image = UIImage(named: cellModel.status.rawValue){
            statusImageView.image = image
        }
    }
    private func getStatusImageView() -> UIImageView{
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(12)
            make.size.equalTo(24)
        }
        return imageView
    }
    private func getTitleLabel() -> UILabel{
        let label = UILabel()
        contentView.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.snp.makeConstraints { make in
            make.trailing.equalTo(statusImageView.snp.leading).offset(5)
            make.centerY.equalTo(statusImageView)
            make.leading.equalToSuperview()
        }
        return label
    }
    private func getDescriptionLabel() -> UILabel{
        let label = UILabel()
        contentView.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 12)
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
        label.font = UIFont.systemFont(ofSize: 12)
        label.snp.makeConstraints { make in
            make.trailing.leading.equalTo(titleLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
        }
        return label
    }
    private func formate(date: Date) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "MM/dd/yyyy"
        let stringDate = formater.string(from: date)
        return stringDate
    }
    private func setContentView(){
        self.contentView.backgroundColor = .black
    }
    private func configCell(){
        setContentView()
        statusImageView = getStatusImageView()
        titleLabel = getDateLabel()
        descriptionLabel = getDescriptionLabel()
        dateLabel = getDateLabel()
    }
}
