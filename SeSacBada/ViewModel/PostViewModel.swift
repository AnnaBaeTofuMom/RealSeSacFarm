//
//  PostViewModel.swift
//  SeSacBada
//
//  Created by 경원이 on 2022/01/05.
//

import Foundation
import UIKit
import XCTest

class PostViewModel {
    var commentArray = Observable(CommentInfo())
    var singlePostBoard: Observable<BoardElement> = Observable(BoardElement(id: 0, text: "", user: User(id: 0, username: "", email: "", provider: .local, confirmed: false, blocked: false, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
    var postId: Observable<Int> = Observable(0)
    var writeUserId: Observable<Int> = Observable(0)
    var nameLabel: Observable<String> = Observable("")
    var contentLabel: Observable<String> = Observable("")
    var dateLabel: Observable<String> = Observable("")
    var commentLabel: Observable<String> = Observable("")
    
    func getReadSinglePost(postId: Int, completion: @escaping (BoardElement?, APIError?, StatusCode? ) -> Void) {
        APIService.readSinglePost(postId: postId) { Boardelement, error, code in
            guard let Boardelement = Boardelement else {
                completion(nil, error, .failed)
                return
            }
            self.singlePostBoard.value = Boardelement
            completion(Boardelement, nil, .success)
        }
    }
    
    func getReadComment(id: Int, completion: @escaping (APIError?, StatusCode?) -> Void) {
        APIService.readComment(id: id) { comment, error, code in
            guard let comment = comment else {
                completion(error, .failed)
                return
            }
            self.commentArray.value = comment

            completion(nil, .success)
            
        }
    }
    
    func fetchDeletePost(id: Int, completion: @escaping (APIError?, StatusCode?) -> Void) {
        print(#function)
        print("이것은 아이디 \(id)")
        APIService.deletePost(id: id) { error, code in
            if code == .success {
                print(#function)
                print("삭제 성공했습니다")
                completion(nil, .success)
            } else {
                print(#function)
                print("삭제 실패했습니다")
                completion(error, .failed)
            }
        }
    }
    
    func postWriteComment(text: String, postId: Int, completion: @escaping (APIError?, StatusCode?) -> Void) {
        APIService.writeComment(text: text, postId: postId) { error, code in
            if code == .success {
                completion(nil, .success)
            } else {
                completion(error, .failed)
            }
        }
    }
    
    func fetchDeleteComment(commentId: Int, completion: @escaping (APIError?, StatusCode?) -> Void) {
        APIService.deleteComment(commentId: commentId) { error, code in
            if code == .success {
                completion(nil, .success)
            } else {
                completion(error, .failed)
            }
        }
    }
    
    
    
}

