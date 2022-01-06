//
//  WriteViewModel.swift
//  SeSacBada
//
//  Created by 경원이 on 2022/01/06.
//

import Foundation
class WriteViewModel {
    var text: Observable<String> = Observable("")
    var postId: Observable<Int> = Observable(0)
    var writeUserId: Observable<Int> = Observable(0)

    
    func postWritePost(text: String, completion: @escaping (APIError?, StatusCode?) -> Void ) {
        APIService.writePost(authorization: UserDefaults.standard.string(forKey: "Token") ?? "", text: text) { error, code in
            if let error = error {
                completion(error, .failed)
                return
            } else {
                
            }
            
            completion(nil, .success)
            
        }
    }
    
    func putEditPost(text: String, postId: Int, completion: @escaping (APIError?, StatusCode?) -> Void ) {
        print("풋에딧포스트를 하긴 하나요?")
        APIService.editPost(text: text, postId: postId) { error, code in
            print("아예 클로저가 실행도 안된다는게 말이 되나??")
            if let error = error {
                print("게시글 수정 요청 실패!!!!")
                completion(error, .failed)
                return
            } else {
                
            }
            print("게시글 수정 요청 성공!!!")
            completion(nil, .success)
        }
    }
}

