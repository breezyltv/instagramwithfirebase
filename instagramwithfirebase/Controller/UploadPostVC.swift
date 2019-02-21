//
//  UploadPostVC.swift
//  instagramwithfirebase
//
//  Created by kevin le on 2/20/19.
//  Copyright © 2019 kevin le. All rights reserved.
//

import UIKit

class UploadPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var picImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add button on the rigth navigation
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareWasPressed))
        
        let picTap = UITapGestureRecognizer(target: self, action: #selector(selectImg))
        picTap.numberOfTapsRequired = 1
        picImg.isUserInteractionEnabled = true
        picImg.addGestureRecognizer(picTap)
    }
    
    @objc func shareWasPressed(){
        
    }
    
    // func to cal pickerViewController
    @objc func selectImg() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

}
