//
//  LoginViewModel.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//

import Foundation

class SignInViewModel {
    var identifier: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var signIn: Observable<UserInfo> = Observable(UserInfo(jwt: "", user: UserClass(id: 0, username: "", email: "", provider: "", confirmed: true, role: Role(id: 0, name: "", roleDescription: "", type: ""), createdAt: "", updatedAt: "")))
    
    func postSignIn(completion: @escaping (APIError?, StatusCode?) -> Void) {
        APIService.signIn(identifier: identifier.value, password: password.value) { user, error, code  in
            
            guard let user = user else {
                print("SignInViewModel-postSignIn")
                completion(error, .failed)
                return
            }
            
            self.signIn.value = user
            UserDefaults.standard.set(user.jwt, forKey: "Token")
            UserDefaults.standard.set(user.user.id, forKey: "Id")
            completion(nil, .success)

        }
        
    }
}

