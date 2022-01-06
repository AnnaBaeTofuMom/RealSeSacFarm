//
//  BoardTableViewCell.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/04.
//

import SnapKit
import UIKit


class BoardTableViewCell: UITableViewCell {
    
    let identifier = "BoardTableViewCell"
    let nameLabel = UILabel()
    let contentLabel = UILabel()
    let dateLabel = UILabel()
    let divider = UIView()
    let commentImage = UIImageView()
    let commentLabel = UILabel()
    let commentStack = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(divider)
        contentView.addSubview(commentStack)
        commentStack.addArrangedSubview(commentImage)
        commentStack.addArrangedSubview(commentLabel)
        
        configure()
        setUpConstrants()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.contentView.layer.borderWidth = 4
        self.contentView.layer.borderColor = UIColor(hue: 0.9972, saturation: 0.02, brightness: 0.81, alpha: 1.0).cgColor
        self.nameLabel.backgroundColor = UIColor(hue: 0.9972, saturation: 0.02, brightness: 0.81, alpha: 1.0)
        self.nameLabel.layer.cornerRadius = 3
        self.nameLabel.clipsToBounds = true
        self.nameLabel.textColor = .gray
        self.nameLabel.text = "name"
        
        self.contentLabel.textColor = .black
        self.contentLabel.text = "contentLabel"
        
        self.dateLabel.textColor = .lightGray
        self.dateLabel.text = "12/25"
        self.commentImage.image = UIImage(systemName: "message")
        self.commentImage.tintColor = .lightGray
        self.commentLabel.textColor = .lightGray
        self.commentLabel.text = "commetLable"
        self.divider.backgroundColor = .lightGray
        
        self.commentStack.spacing = 10
        
        
    }
    
    func setUpConstrants() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().offset(20)
            
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().offset(20)
            make.height.equalTo(1)
        }
        
        commentStack.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        
    }
}

