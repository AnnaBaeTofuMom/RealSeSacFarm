//
//  CommentTableViewCell.swift
//  SeSacBada
//
//  Created by 경원이 on 2022/01/05.
//

import SnapKit
import UIKit

class CommentTableViewCell: UITableViewCell {
    
    let identifier = "CommentTableViewCell"
    let nameLabel = UILabel()
    let contentLabel = UILabel()
    let sideButton = UIButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(sideButton)
        
        
        
        configure()
        setUpConstrants()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
       
        
        self.nameLabel.font = .boldSystemFont(ofSize: 16)
        self.nameLabel.textColor = .black
        self.nameLabel.text = "name"
        
        self.contentLabel.textColor = .black
        self.contentLabel.font = .systemFont(ofSize: 14)
        self.contentLabel.text = "contentLabel"
        
        self.sideButton.setImage(UIImage(named: "메뉴버튼"), for: .normal)
     
    }
    
    func setUpConstrants() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
        }
        
        sideButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-15)
            make.height.width.equalTo(12)
        }
        
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-15)
            
        }
        
        
        
    }
}


