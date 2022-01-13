//
//  CommentViewModel.swift
//  SeSacBada
//
//  Created by 경원이 on 2022/01/06.
//

import Foundation
class CommentViewModel {
    var text: ObservablePrivate<String> = ObservablePrivate("")
    var commentId: ObservablePrivate<Int> = ObservablePrivate(0)
    var postId: ObservablePrivate<Int> = ObservablePrivate(0)
    var writeUserId: ObservablePrivate<Int> = ObservablePrivate(0)

    
    func putEditComment(text: String, commentId: Int, postId: Int, completion: @escaping (APIError?, StatusCode?) -> Void ) {
        print("풋에딧코멘트 합니다~~")
        APIService.editComment(text: text, commentId: commentId , postId: postId) { error, code in
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

