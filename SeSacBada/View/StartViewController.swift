//
//  JoinViewController.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let startButton = UIButton()
    let stackView = UIStackView()
    let askLabel = UILabel()
    let loginLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(StartViewController.loginLabelClicked))
        view.backgroundColor = UIColor(hue: 0.5139, saturation: 0.11, brightness: 0.97, alpha: 1.0)
        view.addSubview(logoImageView)
        view.addSubview(startButton)
        view.addSubview(stackView)
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(150)
            make.height.equalTo(logoImageView.snp.width)
        }
        logoImageView.image = UIImage(named: "새싹바다")
        
        
        startButton.buttonDesign(text: "시작하기")
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        stackView.addArrangedSubview(askLabel)
        stackView.addArrangedSubview(loginLabel)
        stackView.spacing = 8
        
        askLabel.text = "이미 회원이신가요?"
        loginLabel.text = "로그인"
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(tap)
        loginLabel.textColor = .red
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(startButton.snp.bottom).offset(10)
        }
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        
        
        
        
    }
    
    @objc func startButtonClicked() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

    @objc func loginLabelClicked() {
        
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
        
    }

}
