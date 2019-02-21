//
//  SignInViewController.swift
//  instagramwithfirebase
//
//  Created by kevin le on 2/5/19.
//  Copyright © 2019 kevin le. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var userTxt: InsetTextField!
    @IBOutlet weak var passTxt: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userTxt.delegate = self
        passTxt.delegate = self
        
    }
    
    @IBAction func signInWasPressed(_ sender: Any) {
        if userTxt.text != nil && passTxt.text != nil {
            //authenticating user
            AuthService.instance.loginUser(withEmail: userTxt.text!, andPassword: passTxt.text!) { (success, loginError) in
                if success{
//                    //remember user of save in App memory did user
//                    UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "username")
//                    UserDefaults.standard.synchronize()
//                    
//                    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//                    
//                    appDelegate.login()
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let myTabBar = storyboard.instantiateViewController(withIdentifier: "MyTabBar")
                    
                    self.present(myTabBar, animated: true, completion: nil)

                }else{
                    print(String(describing: loginError?.localizedDescription))
                    
                    // show alert message if login falied
                    let alert = CreateAlerts.instance.makeAlertWithOKandCancelButton(title: "Error", mess: String(describing: loginError?.localizedDescription), actionTitle: "ok")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func signUpWasPressed(_ sender: Any) {
        let signUp = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
        present(signUp!, animated: true, completion: nil)
    }
    
    @IBAction func cancelWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgotPassWasPressed(_ sender: Any) {
        let resetVC = storyboard?.instantiateViewController(withIdentifier: "ResetPWViewController")
        present(resetVC!, animated: true, completion: nil)
    }
    
}

extension SignInViewController: UITextFieldDelegate{}
