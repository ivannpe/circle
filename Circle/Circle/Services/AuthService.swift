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
//    func registerUser(withEmail email: String, withPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ())
        // creates user with appropriate fields
    func registerUser(withUniversity university: String,withEmail email: String, withFullName fullname: String, withUsername username:String, withPassword password: String, withSchool school:String, withMajor major:String,withYear year:String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let result = authResult else {
                userCreationComplete(false, error)
                return
            }
            guard let providerId = result.additionalUserInfo?.providerID else { return }
            let userUID = result.user.uid
            let userData = ["university":university,"email": email,"fullname":fullname,"username":username, "password":password,"school":school,"major":major,"year":year,"provider": providerId]
            //adds user to database
            DataService.instance.createDBUser(uid: userUID, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    //logs in existing user if information is valid
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
