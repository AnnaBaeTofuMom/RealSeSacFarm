//
//  BoardViewController.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/04.
//

import UIKit
import RxSwift
import RxDataSources

class BoardViewController: UIViewController {

    let tableView = UITableView()
    let disposeBag = DisposeBag()
    let viewModel = BoardViewModel()
    let floatingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        makeConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.viewModel.getReadPost { error, code in
            if code == .success {
                self.tableView.reloadData()
            }

        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            
            self.viewModel.getReadPost { error, code in
                if code == .success {
                    self.tableView.reloadData()
                }
                
                
            }
        
    }
    
    
    
    func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationItem.title = "새싹바다"
        navigationItem.largeTitleDisplayMode = .automatic
        view.addSubview(floatingButton)
        
        floatingButton.backgroundColor = .systemPink
        floatingButton.setImage(UIImage(systemName: "plus"), for: .normal)
        floatingButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 35), forImageIn: .normal)
        floatingButton.tintColor = .white
        floatingButton.layer.cornerRadius = 30
        
        floatingButton.layer.shadowColor = UIColor.gray.cgColor
        floatingButton.layer.shadowOffset = CGSize.zero
        floatingButton.layer.shadowOpacity = 0.7
        floatingButton.layer.shadowRadius = 6
        floatingButton.addTarget(self, action: #selector(floatingButtonClicked) , for: .touchUpInside)
        
        tableView.backgroundColor = .lightGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: "BoardTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
        
        
        
        
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-40)
            make.width.height.equalTo(60)
        }
    }
    
    @objc func floatingButtonClicked() {
        let vc = WriteViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension BoardViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BoardTableViewCell", for: indexPath) as? BoardTableViewCell else { return UITableViewCell() }
        let row = viewModel.boardArray.value[indexPath.row]
        cell.nameLabel.text = row.user.username
        cell.contentLabel.text = row.text
        cell.dateLabel.text = viewModel.formatDate(date: row.createdAt)
        
        if viewModel.boardArray.value[indexPath.row].comments.count == 0 {
            cell.commentLabel.text = "댓글쓰기"
        } else {
            cell.commentLabel.text = "댓글 \(viewModel.boardArray.value[indexPath.row].comments.count)개"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = PostViewController()
        let row = self.viewModel.boardArray.value[indexPath.row]
        vc.postId = row.id
        vc.viewModel.nameLabel.value = row.user.username
        vc.viewModel.contentLabel.value = row.text
        vc.viewModel.dateLabel.value = self.viewModel.formatDate(date: row.createdAt)
        vc.viewModel.writeUserId.value = row.user.id
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.boardArray.value.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfSection section: Int) -> Int {
        return 1
    }
    
    
    
    
}

