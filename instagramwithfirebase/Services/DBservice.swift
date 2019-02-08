//
//  DBservice.swift
//  instagramwithfirebase
//
//  Created by kevin le on 2/4/19.
//  Copyright © 2019 kevin le. All rights reserved.
//

import Foundation
import Firebase

//get a database reference
let DB_BASE = Database.database().reference();

class DBservice{
    static let instance = DBservice()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: DatabaseReference{
        return _REF_USERS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
        _REF_USERS.child(uid).updateChildValues(userData);
    }
    
}
