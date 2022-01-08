//
//  Endpoint.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//

import Foundation


enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum Endpoint {
    case signUp
    case signIn
    case changePW
    case readPost
    case editPost(postId: Int)
    case deletePost(id: Int)
    case readComment(id: Int)
    case writePost
    case writeComment
    case editComment(postId: Int)
    case deleteComment(postId: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signUp: return .makeEndPoint("auth/local/register")
        case .signIn: return .makeEndPoint("auth/local")
        case .changePW: return .makeEndPoint("custom/change-password")
        case .readPost: return .makeEndPoint("posts?_start=1&_limit=10000")
        case .editPost(postId: let id): return .makeEndPoint("posts/\(id)")
        case .deletePost(id: let id): return .makeEndPoint("posts/\(id)")
        case .readComment(id: let id): return .makeEndPoint("comments?post=\(id)")
        case .writePost: return .makeEndPoint("posts")
        case .writeComment: return .makeEndPoint("comments")
        case .editComment(postId: let id): return .makeEndPoint("comments/\(id)")
        case .deleteComment(postId: let id): return .makeEndPoint("comments/\(id)")
        
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
        
    }

}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        
        return task
    }
    
    static func request(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (APIError?, StatusCode?) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
                print("리퀘스트 실행중")
                print(data)
                print(response)
                print(error)
               
                //네트워크 실패
                guard error == nil else {
                    print("네트워크 실패")
                    completion(.networkFailed, .failed)
                    return
                }
                //알 수 없는 오류
                guard data != nil else {
                    print("알 수 없는 오류")
                    completion(.noData, .failed)
                    return
                }
                //알 수 없는오류
                
                guard let response = response as? HTTPURLResponse else {
                    print("리스폰스가 없는 경우")
                    completion(.invalidResponse, .failed)
                    return
                }
                //리스폰스 옴 == 통신 성공
                
                guard response.statusCode == 200 else {
                    
                    if response.statusCode == 400 {
                        print("400번 에러")
                        completion(.invalidRegister, .failed)
                        return
                    }
                    if response.statusCode == 401 {
                        print("401번 에러")
                        completion(.invalidToken, .failed)
                        return
                    }
                    
                    if response.statusCode == 405 {
                        print("405번 에러")
                        completion(.methodNotAllowed, .failed)
                        return
                    }
                    
                    if response.statusCode == 404 {
                        print("404번 에러 - http Method 확인")
                        completion(.methodNotAllowed, .failed)
                        return
                    }
                    
                    return
                }
                
                
                do {
                    print("200번 성공")
                    completion(nil, .success)
                } catch {
                    print("캐치")
                    completion(.invalidData, .failed)
                    
                }
                
            }
            
            
            
        }
    }

    static func request2<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?, StatusCode?) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
               
                //네트워크 실패
                guard error == nil else {
                    completion(nil, .networkFailed, .failed)
                    return
                }
                //알 수 없는 오류
                guard let data = data else {
                    completion(nil, .noData, .failed)
                    return
                }
                //알 수 없는오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse, .failed)
                    return
                }
                //리스폰스 옴 == 통신 성공
                
                guard response.statusCode == 200 else {

                    
                    if response.statusCode == 400 {
                        print("400번 에러")
                        completion(nil, .invalidRegister, .failed)
                        return
                    }
                    if response.statusCode == 401 {
                        print("401번 에러")
                        completion(nil, .invalidToken, .failed)
                        return
                    }
                    return
                }
                
                
                do {
                    print("200번 성공")
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil, .success)
                } catch {
                    print("캐치씹년")
                    completion(nil, .invalidData, .failed)
                    
                }
                
            }
            
            
            
        }
    }
}

