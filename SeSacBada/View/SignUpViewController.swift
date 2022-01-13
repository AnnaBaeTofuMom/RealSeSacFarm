//
//  JoinViewController.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//

import UIKit
import SnapKit
import Toast
import RxCocoa
import RxSwift


class SignUpViewController: UIViewController {
    
    let email = UITextField()
    let username = UITextField()
    let password = UITextField()
    let passwordCheck = UITextField()
    let joinButton = UIButton()
    let disposeBag = DisposeBag()
    
    let viewModel = SignUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.username.bind { text in
            print("bind:",text)
            self.username.text = text
        }
        viewModel.email.bind { text in
            self.email.text = text
        }
        viewModel.password.bind { text in
            self.password.text = text
        }
        
        Observable.combineLatest(
            email.rx.text.orEmpty.map(checkEmailValid),
            password.rx.text.orEmpty.map(checkPasswordValid),
            resultSelector: { s1, s2 in s1 && s2 }
        )
            .subscribe(onNext: { b in
                print(b)
                self.joinButton.isEnabled = b
                if b == true {
                    self.joinButton.setTitle("회원가입", for: .normal)
                } else {
                    self.joinButton.setTitle("빈 칸을 채워주세요", for: .disabled)
                }
            })
            .disposed(by: disposeBag)

        view.backgroundColor = .white
        view.addSubview(email)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(passwordCheck)
        view.addSubview(joinButton)
        
        email.textFieldDesign(text: "Email")
        username.textFieldDesign(text: "Nickname")
        password.textFieldDesign(text: "Password")
        passwordCheck.textFieldDesign(text: "Password Check")
        joinButton.buttonDesign(text: "회원가입", unabledText: "빈 칸을 채워주세요")
        
        
        email.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        username.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(email.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        password.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(username.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        passwordCheck.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(password.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        joinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordCheck.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        joinButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
    
        
    }
    
    func checkEmailValid(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
               let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
               return emailTest.evaluate(with: text)
    }
    
    func checkPasswordValid(text: String) -> Bool {
        if text.count >= 1 {
            return true
        } else {
            return false
        }
    }
    
    @objc func signupButtonClicked() {
        print(#function)
        viewModel.email.value = email.text ?? ""
        viewModel.username.value = username.text ?? ""
        viewModel.password.value = password.text ?? ""
        
        if password.text == passwordCheck.text {
            viewModel.postSignUp { error, code in
                
                if code == .failed {
                    self.view.makeToast("회원가입이 실패 되었습니다")
                }
                
                if error != nil {
                    
                } else {
                    self.view.makeToast("회원가입 완료")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.navigationController?.pushViewController(SignInViewController(), animated: true)
                    }
                }
            }
        }
    }

}
