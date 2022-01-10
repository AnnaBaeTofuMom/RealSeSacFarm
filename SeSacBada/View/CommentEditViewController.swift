//
//  CommentEditViewController.swift
//  SeSacBada
//
//  Created by 경원이 on 2022/01/06.
//

import Foundation
import SnapKit
import Toast
import UIKit
import RxSwift

class CommentEditViewController: UIViewController {
    
    let textView = UITextView()
    let viewModel = CommentViewModel()
    var commentId = 0
    var writeUserId = 0
    var postId = 0
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        makeConstraints()
        print("commentId", self.viewModel.commentId.value)
        print("writeUserId", self.viewModel.writeUserId.value)
        print("postId", self.viewModel.postId.value)
        commentId = self.viewModel.commentId.value
        writeUserId = self.viewModel.writeUserId.value
        postId = self.viewModel.postId.value
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func configure() {
        view.addSubview(textView)
        view.backgroundColor = .white
        
        
        let completeBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(onCompleteButtonClicked(_:)))
                self.navigationItem.rightBarButtonItem  = completeBarButtonItem
        self.navigationItem.title = "댓글 수정"
        
        textView.backgroundColor = .white
        textView.isEditable = true
        textView.text = self.viewModel.text.value
        
    }
    
    func makeConstraints() {
        textView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc func onCompleteButtonClicked(_ sender: Any){
        self.viewModel.putEditComment(text: self.textView.text, commentId: self.viewModel.commentId.value, postId: self.viewModel.postId.value) { error, code in
            if code == .success {
                self.view.makeToast("댓글 수정 완료")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.view.makeToast("댓글 수정 실패")
            }
            if error == .invalidToken {
                self.view.makeToast("세션이 만료되었습니다.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    UserDefaults.standard.set("", forKey: "Token")
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    
                    let nav = UINavigationController(rootViewController: SignInViewController())
                    windowScene.windows.first?.rootViewController = nav
                    windowScene.windows.first?.makeKeyAndVisible()
                }

            }
        }
        
    }
    
    
}
