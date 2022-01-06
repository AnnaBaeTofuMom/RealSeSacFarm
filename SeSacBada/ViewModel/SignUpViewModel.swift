//
//  SignUpViewModel.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//

import Foundation

class SignUpViewModel {
    var username: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var signUp: Observable<UserInfo> = Observable(UserInfo(jwt: "", user: UserClass(id: 0, username: "", email: "", provider: "", confirmed: true, role: Role(id: 0, name: "", roleDescription: "", type: ""), createdAt: "", updatedAt: "")))
    var errorMessage: Observable<String> = Observable("")
    
    func postSignUp(completion: @escaping (APIError?, StatusCode?) -> Void) {
        APIService.signUp(username: username.value, email: email.value, password: password.value) { user, error, code  in
            guard let user = user else {
                completion(error, .failed)
                return
            }
            self.signUp.value = user
            UserDefaults.standard.set(self.email.value, forKey: "Email")
            UserDefaults.standard.set(self.password.value, forKey: "Password")
            
            
            completion(nil, .success)
        }
        
    }
}

