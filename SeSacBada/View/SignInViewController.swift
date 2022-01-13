//
//  LoginViewController.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//
import Foundation
import UIKit
import SnapKit
import Toast

class SignInViewController: UIViewController {
    
    let email = UITextField()
    let password =  UITextField()
    let loginButton = UIButton()
    
    let viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .white
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(loginButton)
        
        email.textFieldDesign(text: "Email")
        password.textFieldDesign(text: "Password")
        loginButton.buttonDesign(text: "Login", unabledText: "빈 칸을 채워주세요")
        
        email.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        password.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(email.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(password.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        email.text = UserDefaults.standard.string(forKey: "Email") ?? ""
        password.text = UserDefaults.standard.string(forKey: "Password") ?? ""
    }
    
    @objc func loginButtonClicked() {
        print("로그인시도")
        DispatchQueue.main.async {
            self.viewModel.identifier.value = self.email.text ?? ""
            self.viewModel.password.value = self.password.text ?? ""
           
            
            self.viewModel.postSignIn { error, statusCode in
                
                if statusCode == .failed {
                    self.view.makeToast("로그인에 실패했습니다.")
                }
                
                if error != nil {
                } else {
                    self.view.makeToast("로그인 성공")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: BoardViewController())
                                    windowScene.windows.first?.makeKeyAndVisible()
                        
                    }
                }
            }
        }
        
        
    }

}

