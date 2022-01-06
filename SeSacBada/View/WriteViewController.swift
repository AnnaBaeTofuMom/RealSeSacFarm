//
//  WriteViewController.swift
//  SeSacBada
//
//  Created by 경원이 on 2022/01/06.
//

import UIKit
import SnapKit
import Toast

class WriteViewController: UIViewController {
    
    let textView = UITextView()
    let viewModel = WriteViewModel()
    var postId = 0
    var writeUserId = 0
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        makeConstraints()
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
        
        if self.viewModel.postId.value != 0 {
            self.textView.text = self.viewModel.text.value
        }
        
        
        let completeBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(onCompleteButtonClicked(_:)))
                self.navigationItem.rightBarButtonItem  = completeBarButtonItem
        self.navigationItem.title = "새싹바다 글쓰기"
        
        if self.postId == 0 {
            self.textView.text = ""
        } else {
            if self.writeUserId == UserDefaults.standard.integer(forKey: "Id") {
                print("본인이썼군")
            } else {
                print("본인이 안썼군")
                self.textView.text = ""
            }
        }
        
        textView.backgroundColor = .white
        textView.isEditable = true
        
    }
    
    func makeConstraints() {
        textView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc func onCompleteButtonClicked(_ sender: Any){
        print(#function)
        if self.postId != 0 {
            print("postId 0 아님 = 본인이 쓴글")
            self.viewModel.putEditPost(text: self.textView.text, postId: self.postId) { error, code in
                if code == .failed {
                    self.view.makeToast("수정 실패 - 다시 시도해주세요")
                    print("기존글 수정하기 실패~~")
                } else {
                    self.view.makeToast("수정이 완료되었습니다.")
                    print("성공~~~")
                }
                
            }
        } else {
            print("postId 0임, 본인이 쓴 글 아님 근데 사실 여기는 작동 잘함 원래도")
            self.viewModel.postWritePost(text: self.textView.text) { error, code in
                if code == .failed {
                    self.view.makeToast("작성 실패")
                } else {
                    self.view.makeToast("작성 성공")
                }
            }
        }
        
    }
}

