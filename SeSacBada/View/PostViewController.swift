//
//  PostViewController.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/05.
//

import UIKit
import SnapKit
import Toast
import XCTest

class PostViewController: UIViewController {
    let mainContentView = UIView()
    let profileImage = UIImageView()
    let nameLabel = UILabel()
    let contentLabel = UILabel()
    let dateLabel = UILabel()
    let divider1 = UIView()
    let divider2 = UIView()
    let divider3 = UIView()
    let commentImage = UIImageView()
    let commentCountLabel = UILabel()
    let tableView = UITableView()
    let nameDateStack = UIStackView()
    let commentStack = UIStackView()
    var postId: Int = 0
    var writeUserId: Int = 0
    let viewModel = PostViewModel()
    let commentWriteView = UIView()
    let commentWriteViewStack = UIStackView()
    let commentTextView = UITextView()
    let commentRegisterButton = UIButton()
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.viewModel.getReadSinglePost(postId: self.postId) { boardelement, error, code in
            if code == .success {
                self.nameLabel.text = self.viewModel.singlePostBoard.value.user.username
                self.contentLabel.text = self.viewModel.singlePostBoard.value.text
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
        
        self.viewModel.getReadComment(id: postId) { error, code in
            if code == .success {
                self.tableView.reloadData()
                if self.viewModel.commentArray.value.count == 0 {
                    self.commentCountLabel.text = "댓글달기"
                } else {
                    self.commentCountLabel.text = "댓글 \(self.viewModel.commentArray.value.count) 개"
                }
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
    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        self.viewModel.getReadSinglePost(postId: self.postId) { boardelement, error, code in
            if code == .success {
                self.nameLabel.text = self.viewModel.singlePostBoard.value.user.username
                self.contentLabel.text = self.viewModel.singlePostBoard.value.text
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
        print("this is post Id \(postId)")
        self.viewModel.getReadComment(id: postId) { error, code in
            if code == .success {
                self.tableView.reloadData()
                if self.viewModel.commentArray.value.count == 0 {
                    self.commentCountLabel.text = "댓글달기"
                } else {
                    self.commentCountLabel.text = "댓글 \(self.viewModel.commentArray.value.count) 개"
                }
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
    
    func configure() {
        
        viewModel.nameLabel.bind { value in
            self.nameLabel.text = value
        }
        viewModel.dateLabel.bind { value in
            self.dateLabel.text = value
        }
        viewModel.contentLabel.bind { value in
            self.contentLabel.text = value
        }
        
        viewModel.writeUserId.bind { value in
            self.writeUserId = value
        }
        
        
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
        
        view.addSubview(mainContentView)
        view.addSubview(tableView)
        view.addSubview(commentWriteView)
        commentWriteView.addSubview(commentWriteViewStack)
        commentWriteViewStack.addArrangedSubview(commentTextView)
        commentWriteViewStack.addArrangedSubview(commentRegisterButton)
        commentWriteView.backgroundColor = .white
        commentTextView.backgroundColor = UIColor(hue: 0.9972, saturation: 0.02, brightness: 0.81, alpha: 0.4)
        commentTextView.layer.cornerRadius = 15
        commentTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        contentLabel.numberOfLines = 0

        commentRegisterButton.layer.cornerRadius = 10
        commentRegisterButton.backgroundColor = UIColor(hue: 0.4472, saturation: 0.72, brightness: 0.96, alpha: 1.0)
        commentRegisterButton.setTitle("등록", for: .normal)
        commentRegisterButton.addTarget(self, action: #selector(registerCommentButtonClicked), for: .touchUpInside)
        
        commentWriteViewStack.axis = .horizontal
        commentWriteViewStack.spacing = 10
        view.backgroundColor = .white
        nameDateStack.addArrangedSubview(nameLabel)
        nameDateStack.addArrangedSubview(dateLabel)
        commentStack.addArrangedSubview(commentImage)
        commentStack.addArrangedSubview(commentCountLabel)
        
        [profileImage, contentLabel, divider1, divider2,  divider3, nameDateStack, commentStack].forEach {
            mainContentView.addSubview($0)
        }
        
        
        nameDateStack.axis = .vertical
        nameDateStack.spacing = 10
        commentStack.axis = .horizontal
        commentStack.spacing = 10
        
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "수정", image: nil, identifier: nil, discoverabilityTitle: nil, handler: { action in
                    self.editButtonClicked()
                }),
                UIAction(title: "삭제", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: .destructive, handler: { action in
                    self.deleteButtonClicked()
                })
            
            ]
        }
        var demoMenu: UIMenu {
            return UIMenu(title: "내 포스트 수정", image: nil, identifier: nil, options: [], children: menuItems)
        }
        let editButton = UIBarButtonItem(title: nil, image: UIImage(named: "메뉴버튼"), primaryAction: nil, menu: demoMenu)
        
        navigationItem.rightBarButtonItem = editButton
        
        mainContentView.backgroundColor = .white
        profileImage.image = UIImage(systemName: "person")
        profileImage.tintColor = .lightGray
        
        
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        
        
        
        divider1.backgroundColor = .lightGray
        divider2.backgroundColor = .lightGray
        divider3.backgroundColor = .lightGray
        
        commentImage.image = UIImage(systemName: "message")
        commentImage.tintColor = .lightGray
        
        
        if viewModel.commentArray.value.count == 0 {
            commentCountLabel.text = "댓글달기"
        } else {
            commentCountLabel.text = "댓글 \(viewModel.commentArray.value.count)개"
        }
        
        
        
        
    }
    
    @objc func registerCommentButtonClicked() {
        print(#function)
        print("현재 포스트 아이디 = \(self.postId)")
        self.viewModel.postWriteComment(text: commentTextView.text, postId: self.postId) { error, code in
            print("----registerCommentButtonClicked완료----")
            if code == .success {
                self.view.makeToast("코멘트 등록 완료")
                self.commentTextView.text = ""
                self.viewModel.getReadComment(id: self.postId) { error, code in
                    self.tableView.reloadData()
                    self.commentCountLabel.text = "댓글 \(self.viewModel.commentArray.value.count)개"
                }
                
            } else {
                
                if error == .invalidToken {
                    self.view.makeToast("세션이 만료되었습니다.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        UserDefaults.standard.set("", forKey: "Token")
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        
                        let nav = UINavigationController(rootViewController: SignInViewController())
                        windowScene.windows.first?.rootViewController = nav
                        windowScene.windows.first?.makeKeyAndVisible()
                    }

                } else {
                    self.view.makeToast("코멘트 등록 실패")
                }
            }
        }
    }
    
    @objc func editButtonClicked() {
        if UserDefaults.standard.integer(forKey: "Id") == self.writeUserId {
            let vc = WriteViewController()
            vc.postId = self.postId
            vc.writeUserId = self.writeUserId
            vc.textView.text = self.contentLabel.text
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            view.makeToast("본인 글만 수정할 수 있습니다.")
        }
        
    }
    
    @objc func deleteButtonClicked() {
        let alert = UIAlertController(title: "삭제하기", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { action in
            if UserDefaults.standard.integer(forKey: "Id") == self.writeUserId {
                
                self.viewModel.fetchDeletePost(id: self.postId) { error, code in
                    if code == .failed {
                        if error == .invalidToken {
                            self.view.makeToast("세션이 만료되었습니다.")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                UserDefaults.standard.set("", forKey: "Token")
                                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                                
                                let nav = UINavigationController(rootViewController: SignInViewController())
                                windowScene.windows.first?.rootViewController = nav
                                windowScene.windows.first?.makeKeyAndVisible()
                            }

                        } else {
                            self.view.makeToast("삭제에 실패했습니다. 다시 시도해주세요.")
                        }
                    } else {
                        
                        self.view.makeToast("삭제 완료")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                self.view.makeToast("본인 글만 삭제할 수 있습니다.")
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default) { action in
            
        }
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true) {
            
        }
        
    }
    
    @objc func deleteCommentButtonClicked(sender: UIButton) {
        
        if self.viewModel.commentArray.value[sender.tag].user.id == UserDefaults.standard.integer(forKey: "Id") {
            self.viewModel.fetchDeleteComment(commentId: self.viewModel.commentArray.value[sender.tag].id) { error, code in
                if code == .failed {
                    self.view.makeToast("삭제에 실패했습니다. 다시 시도해주세요.")
                } else {
                    if error == .invalidToken {
                        self.view.makeToast("세션이 만료되었습니다.")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            UserDefaults.standard.set("", forKey: "Token")
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                            
                            let nav = UINavigationController(rootViewController: SignInViewController())
                            windowScene.windows.first?.rootViewController = nav
                            windowScene.windows.first?.makeKeyAndVisible()
                        }

                    } else {
                        self.view.makeToast("삭제 완료")
                        self.viewModel.getReadComment(id: self.postId) { error, code in
                            self.tableView.reloadData()
                    }
                    
                    }
                    
                }
            }
        }
    }
    
    @objc func editCommentButtonClicked(sender: UIButton) {
        if self.viewModel.commentArray.value[sender.tag].user.id == UserDefaults.standard.integer(forKey: "Id") {
            
            let vc = CommentEditViewController()
            print("post id", self.postId)
            print("commentId", self.viewModel.commentArray.value[sender.tag].id)
            print("writeUserId", self.viewModel.commentArray.value[sender.tag].user.id)
            print("원래글", vc.viewModel.text.value)
            print("전달 된 글", self.viewModel.commentArray.value[sender.tag].comment)
            vc.viewModel.postId.value = self.postId
            vc.viewModel.commentId.value = self.viewModel.commentArray.value[sender.tag].id
            vc.viewModel.writeUserId.value = self.viewModel.commentArray.value[sender.tag].user.id
            vc.viewModel.text.value = self.viewModel.commentArray.value[sender.tag].comment
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            view.makeToast("본인 댓글만 수정 가능합니다.")
        }
    }
    
    func makeConstraints() {
        mainContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(nameDateStack.snp.height)
        }
        
        nameDateStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
        }
        
        
        divider1.snp.makeConstraints { make in
            make.top.equalTo(nameDateStack.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(1)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        divider2.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(1)
        }
        
        commentStack.snp.makeConstraints { make in
            make.top.equalTo(divider2.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
        }
        
        divider3.snp.makeConstraints { make in
            make.top.equalTo(commentStack.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainContentView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            //make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        commentWriteView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        commentWriteViewStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(15)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.height.equalTo(35)
            
        }
        
        commentRegisterButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.width.height.equalTo(35)
        }
    }
    
    

}


extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.commentArray.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell" , for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = viewModel.commentArray.value[indexPath.row].user.username
        cell.contentLabel.text = viewModel.commentArray.value[indexPath.row].comment
        cell.commentDeleteButton.addTarget(self, action: #selector(deleteCommentButtonClicked(sender: )), for: .touchUpInside)
        cell.commentDeleteButton.tag = indexPath.row
        cell.commentEditbutton.addTarget(self, action: #selector(editCommentButtonClicked), for: .touchUpInside)
        cell.commentEditbutton.tag = indexPath.row
        
        
        return cell
        
    }
    
    
}



