//
//  AuthService.swift
//  instagramwithfirebase
//
//  Created by kevin le on 2/7/19.
//  Copyright © 2019 kevin le. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthService {
    // create a static for variable that's still alive
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) -> ()){
        
        //auth with firebase
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            // ...
            guard let user = user?.user else {
                //if user registration is false
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email]
            // create a database for user
            DBservice.instance.createDBUser(uid: user.uid, userData: userData as Dictionary<String, Any>)
            //registration completed
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
            if error != nil{
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
}
