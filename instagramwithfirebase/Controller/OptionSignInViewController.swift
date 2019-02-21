//
//  OptionSignInViewController.swift
//  instagramwithfirebase
//
//  Created by kevin le on 2/5/19.
//  Copyright © 2019 kevin le. All rights reserved.
//

import UIKit

class OptionSignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInWithEmail(_ sender: Any) {
        let signInVC = storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
        present(signInVC!, animated: true, completion: nil)
    }
    

}
