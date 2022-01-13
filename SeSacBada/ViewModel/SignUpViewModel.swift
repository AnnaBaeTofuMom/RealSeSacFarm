//
//  SignUpViewModel.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//

import Foundation

class SignUpViewModel {
    var username: ObservablePrivate<String> = ObservablePrivate("")
    var email: ObservablePrivate<String> = ObservablePrivate("")
    var password: ObservablePrivate<String> = ObservablePrivate("")
    var signUp: ObservablePrivate<UserInfo> = ObservablePrivate(UserInfo(jwt: "", user: UserClass(id: 0, username: "", email: "", provider: "", confirmed: true, role: Role(id: 0, name: "", roleDescription: "", type: ""), createdAt: "", updatedAt: "")))
    var errorMessage: ObservablePrivate<String> = ObservablePrivate("")
    
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

