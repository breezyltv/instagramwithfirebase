//
//  ResetPWViewController.swift
//  instagramwithfirebase
//
//  Created by kevin le on 2/5/19.
//  Copyright © 2019 kevin le. All rights reserved.
//

import UIKit

class ResetPWViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTxt.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func resetWasPressed(_ sender: Any) {
        if emailTxt.text!.isEmpty {
            let alert = CreateAlerts.instance.makeAlertWithOKandCancelButton(title: "Please", mess: "enter your email!", actionTitle: "ok")
            present(alert, animated: true, completion: nil)
            return
        }
        
        AuthService.instance.resetPassword(withEmail: self.emailTxt.text!) { (success, resetFailed) in
            if success {
                let alert = CreateAlerts.instance.makeAlertWithOKandCancelButton(title: "A link has sent successfully", mess: "check your email!", actionTitle: "ok")
                self.present(alert, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }else{
                print(String(describing: resetFailed?.localizedDescription))
                let alert = CreateAlerts.instance.makeAlertWithOKandCancelButton(title: "Reset failed", mess: String(describing: resetFailed?.localizedDescription), actionTitle: "ok")
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func cancenWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
