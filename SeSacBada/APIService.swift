//
//  APIService.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//

import Foundation


enum APIError : Error {
    case invalidResponse
    case noData
    case networkFailed
    case invalidRegister
    case invalidData
    case invalidToken
    case invalidLogin
    case methodNotAllowed
}

enum StatusCode : Int {
    case success = 200
    case failed = 400
}

class APIService {
    
    static func signUp(username: String, email: String, password: String, completion: @escaping (UserInfo?, APIError?, StatusCode?) -> Void) {
        let url = Endpoint.signUp.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request2(endpoint: request, completion: completion)

    }
    
    static func signIn(identifier: String, password: String, completion: @escaping (UserInfo?, APIError?, StatusCode?) -> Void) {
        let url = Endpoint.signIn.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
    
        URLSession.request2(endpoint: request, completion: completion)
    }
    
    static func readPost(completion: @escaping (Board?, APIError?, StatusCode?) -> Void) {
        let url = Endpoint.readPost.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        let token = UserDefaults.standard.string(forKey: "Token")!
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        URLSession.request2(endpoint: request, completion: completion)
        
    }
    
    static func readComment(id: Int, completion: @escaping (CommentInfo?, APIError?, StatusCode?) -> Void) {
        let url = Endpoint.readComment(id: id).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        let token = UserDefaults.standard.string(forKey: "Token")!
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        URLSession.request2(endpoint: request, completion: completion)
    }
    
    static func writeComment(text: String, postId: Int, completion: @escaping (APIError?, StatusCode?) -> Void) {
        let url = Endpoint.writeComment.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "comment=\(text)&post=\(postId)".data(using: .utf8, allowLossyConversion: false)
        let token = UserDefaults.standard.string(forKey: "Token")!
        request.setValue("bearer \(token)", forHTTPHeaderField: "authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func writePost(authorization: String, text: String, completion: @escaping (APIError?, StatusCode?) -> Void) {
        let url = Endpoint.writePost.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "authorization=\(authorization)&text=\(text)".data(using: .utf8, allowLossyConversion: false)
        let token = UserDefaults.standard.string(forKey: "Token")!
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func editPost(text: String, postId: Int, completion: @escaping ( APIError?, StatusCode?) -> Void) {
        let url = Endpoint.editPost(postId: postId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.PUT.rawValue
        let token = UserDefaults.standard.string(forKey: "Token")!
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    static func deletePost(id: Int, completion: @escaping (APIError?, StatusCode?) -> Void) {
        let url = Endpoint.deletePost(id: id).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.DELETE.rawValue
        let token = UserDefaults.standard.string(forKey: "Token")!
        request.setValue("bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func deleteComment(commentId: Int, completion: @escaping (APIError?, StatusCode?) -> Void) {
        let url = Endpoint.deleteComment(commentId: commentId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("\(commentId)", forHTTPHeaderField: "post")
        let token = UserDefaults.standard.string(forKey: "Token")!
        request.setValue("bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func editComment(text: String, commentId: Int, postId: Int, completion: @escaping (APIError?, StatusCode?) -> Void) {
        print("요청하는 코멘트 아이디 \(commentId)")
        let url = Endpoint.editComment(commentId: commentId).url
        var request = URLRequest(url: url)
        request.httpMethod = Method.PUT.rawValue
        let token = UserDefaults.standard.string(forKey: "Token")!
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "comment=\(text)&post=\(postId)".data(using: .utf8, allowLossyConversion: false)
        URLSession.request(endpoint: request, completion: completion)
    }
    
    
    
    
}
