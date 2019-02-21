//
//  DBservice.swift
//  instagramwithfirebase
//
//  Created by kevin le on 2/4/19.
//  Copyright © 2019 kevin le. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

//get a database reference
let DB_BASE = Database.database().reference()
//get a storage reference
let STORAGE = Storage.storage().reference()

class DBservice{
    static let instance = DBservice()
    
    private var _REF_BASE = DB_BASE
    // create a ID string name for images
    //private var imgName = NSUUID().uuidString;
    private var _REF_STORAGE = STORAGE.child("\(NSUUID().uuidString).jpg")
    //create users table
    private var _REF_USERS = DB_BASE.child("users")
    //create posts table
    private var _REF_POSTS = DB_BASE.child("posts")
    
    var REF_BASE: DatabaseReference{
        return _REF_USERS
    }
    
    var REF_POSTS: DatabaseReference{
        return _REF_POSTS
    }
    
    var REF_STORAGE: StorageReference{
        return _REF_STORAGE
    }
    
    
    //create or update a User Table
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
        _REF_USERS.child(uid).updateChildValues(userData);
    }
    
    func createDBPosts(postData: Dictionary<String, Any>){
        _REF_POSTS.childByAutoId().updateChildValues(postData)
    }
    
    //upload images
    func uploadImg(uid: String, imgData: UIImage){
       
        _REF_STORAGE.putData(imgData.jpegData(compressionQuality: 1.0)!, metadata: nil) { (metadata, error) in
            if(error != nil) {
                print("Could not upload img!")
                print(String(describing: error?.localizedDescription))
                return
            }
            //get a img URL after uploaded
            self._REF_STORAGE.downloadURL(completion: { (url, error) in
                if(error != nil) {
                    print(String(describing: error?.localizedDescription))
                    return
                }
                //print("upload url: \(url!.absoluteString)")
                //update profile img URL to user
                DBservice.instance.createDBUser(uid: uid, userData: ["profileImgURL": url!.absoluteString])
            })
        }
    }
    
    func getUserInfo(uid: String, handler: @escaping (_ userInfo: UserInfo) -> ()){
        
        _REF_USERS.child(uid).observeSingleEvent(of: .value) { (userTable) in
            if userTable.value is NSNull {
                print("User Data is not exist !")
                return
            }
            let fullname = userTable.childSnapshot(forPath: "fullname").value as! String
            let username = userTable.childSnapshot(forPath: "username").value as! String
            let bio = userTable.childSnapshot(forPath: "bio").value as! String
            let web = userTable.childSnapshot(forPath: "web").value as! String
            let ava = userTable.childSnapshot(forPath: "profileImgURL").value as! String
            let uInfo = UserInfo(fullname: fullname, username: username, bio: bio, web: web, avaUrl: ava)
                
            handler(uInfo)
            
        }
    }
        
}
