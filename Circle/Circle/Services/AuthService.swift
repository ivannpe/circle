//
//  AuthService.swift
//  Circle
//
//  Created by Ivanna Peña on 5/3/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, withPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let result = authResult else {
                userCreationComplete(false, error)
                return
            }
            guard let providerId = result.additionalUserInfo?.providerID else { return }
            let userUID = result.user.uid
            let userData = ["provider": providerId, "email": email]
            //DataService.instance.createDBUser(uid: userUID, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, withPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
}
