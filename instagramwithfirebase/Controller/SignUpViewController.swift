//
//  SignUpViewController.swift
//  instagramwithfirebase
//
//  Created by kevin le on 2/5/19.
//  Copyright © 2019 kevin le. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var imgUpload: UIImageView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var bioTxt: UITextField!
    @IBOutlet weak var webTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameTxt.delegate = self
        passTxt.delegate = self
        confirmPassTxt.delegate = self
        fullnameTxt.delegate = self
        bioTxt.delegate = self
        webTxt.delegate = self
        
        
        // declare select image tap
        let avaTap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.loadImg(_:)))
        avaTap.numberOfTapsRequired = 1
        imgUpload.isUserInteractionEnabled = true
        imgUpload.addGestureRecognizer(avaTap)
        
        // alignment
        imgUpload.frame = CGRect(x: self.view.frame.size.width / 2 - 40, y: 40, width: 80, height: 80)
        // round ava
        imgUpload.layer.cornerRadius = imgUpload.frame.size.width / 2
        imgUpload.clipsToBounds = true
        
    }

    @IBAction func createAccountWasPressed(_ sender: Any) {
        //get usernam from email
        var username = self.usernameTxt.text?.components(separatedBy: "@")
        
        if passTxt.text != confirmPassTxt.text{
            let alert = CreateAlerts.instance.makeAlertWithOKandCancelButton(title: "Password", mess: "do not match", actionTitle: "ok")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        if usernameTxt.text != nil && passTxt.text != nil && fullnameTxt.text != nil{
            AuthService.instance.registerUser(withEmail: self.usernameTxt.text!, andPassword: self.passTxt.text!) { (success, registrationError) in
                if success{
                    
                    //if registation has completed successfully, log in
                    AuthService.instance.loginUser(withEmail: self.usernameTxt.text!, andPassword: self.passTxt.text!, loginComplete: { (success, nil) in
                        print("Successfully registed user")
                    })
                    
                    //upload image profile
                    DBservice.instance.uploadImg(uid: (Auth.auth().currentUser?.uid)!, imgData: self.imgUpload.image!)
                    
                    //update user information
                    let userInfo = ["username": username![0],"fullname": self.fullnameTxt.text!, "bio":self.bioTxt.text!, "web":self.webTxt.text!]
                    DBservice.instance.createDBUser(uid: (Auth.auth().currentUser?.uid)!, userData: userInfo)
                    

                }else{
                    let alert = CreateAlerts.instance.makeAlertWithOKandCancelButton(title: "Error", mess: String(describing: registrationError?.localizedDescription), actionTitle: "ok")
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
        }else{
            let alert = CreateAlerts.instance.makeAlertWithOKandCancelButton(title: "Please", mess: "fill all fields!", actionTitle: "ok")
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    @IBAction func cancelWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // call picker to select image
    @objc func loadImg(_ recognizer:UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    // show selected image to ImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        var selectedImgFromPicker: UIImage?
        if let editedImg = info[.editedImage] as? UIImage {
            selectedImgFromPicker = editedImg;
        }else if let originalImg = info[.originalImage] as? UIImage {
            selectedImgFromPicker = originalImg;
        }
        
        if let selectedImg = selectedImgFromPicker{
            imgUpload.image = selectedImg
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension SignUpViewController: UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{}
