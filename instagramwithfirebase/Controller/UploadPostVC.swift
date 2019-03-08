//
//  UploadPostVC.swift
//  instagramwithfirebase
//
//  Created by kevin le on 2/20/19.
//  Copyright © 2019 kevin le. All rights reserved.
//

import UIKit

class UploadPostVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var picImg: UIImageView!
    
    @IBOutlet weak var captionTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captionTxt.delegate = self
        
        // declare select image tap
        let avaTap = UITapGestureRecognizer(target: self, action: #selector(UploadPostVC.loadImg(_:)))
        avaTap.numberOfTapsRequired = 1
        picImg.isUserInteractionEnabled = true
        picImg.addGestureRecognizer(avaTap)
    }
    
    @objc func shareWasPressed(){
        
    }
    
    // call picker to select image
    @objc func loadImg(_ recognizer:UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // add button on the right navigation
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareWasPressed))
        
        // add button on the left navigation
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelWasPressed))
        

        
        var selectedImgFromPicker: UIImage?
        if let editedImg = info[.editedImage] as? UIImage {
            selectedImgFromPicker = editedImg;
        }else if let originalImg = info[.originalImage] as? UIImage {
            selectedImgFromPicker = originalImg;
        }

        if let selectedImg = selectedImgFromPicker{
            picImg.image = selectedImg
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //reload to cancel upload post
    @objc func cancelWasPressed(){
        self.viewDidLoad()
    }

}
