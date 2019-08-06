//
//  UploadViewController.swift
//  LaunchingMissile
//
//  Created by Venkata Pranathi on 30/07/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import UIKit
import Photos

class UploadViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    var imagePickedNow: UIImage?
    
    var selectedImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkPermission()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
    }

    func checkPermission() {
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.selectPhotoFromGallery()
                } else {
                    self.displayAlert(alertMsg: "This app do not have permission to use the photo library. Please enable it in settings.")
                }
            })
        } else if photos == .authorized {
            self.selectPhotoFromGallery()
            
        } else if photos == .restricted || photos == .denied {
            self.displayAlert(alertMsg: "This app do not have permission to use the photo library. Please enable it in settings.")
        }
    }
    
    @IBAction func uploadpic(_ sender: Any) {
        self.checkPermission()
    }
    
    func selectPhotoFromGallery() {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func displayAlert(alertMsg: String) {
        let alert = UIAlertController(title: "Alert", message: alertMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickedNow = pickedImage
        }
        
        dismiss(animated: true, completion: nil)

        if self.imagePickedNow != nil {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
            vc?.imageName = self.selectedImageName
            vc?.pickedImage = self.imagePickedNow
            self.navigationController?.pushViewController(vc!, animated: true)
        } else {
            self.displayAlert(alertMsg: "Please pick an image from your photo library")
        }
        

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}
