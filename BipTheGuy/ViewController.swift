//
//  ViewController.swift
//  BipTheGuy
//
//  Created by Christian Guma on 6/11/19.
//  Copyright © 2019 Christian Guma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var imageToPunch: UIImageView!
    
    var audioplayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func animateImage() {
        let bounds = self.imageToPunch.bounds
        
        self.imageToPunch.bounds = CGRect(x: self.imageToPunch.bounds.origin.x + 60, y:self.imageToPunch.bounds.origin.y + 60, width: self.imageToPunch.bounds.size.width - 60, height: self.imageToPunch.bounds.size.height - 60)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1000, options: [], animations: { self.imageToPunch.bounds = bounds }, completion: nil)
        
    }
    
    func playsound(soundname:String, audioplayer: inout AVAudioPlayer){
        // play sound
        
        // can we load from somwhere?
        if let sound = NSDataAsset(name:soundname) {
            //check
            do {
                try audioplayer = AVAudioPlayer(data: sound.data)
                audioplayer.play()
            } catch {
                // if not valid
            }
        } else {
            // no work
            print("ERROR: File \(soundname) didn't load")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageToPunch.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) { animateImage()
        playsound(soundname: "order66", audioplayer: &audioplayer)
        
    }

@IBAction func libraryPressed(_ sender: UIButton) {
    imagePicker.sourceType = .photoLibrary
    
    imagePicker.delegate = self
    
    present(imagePicker, animated: true, completion: nil)
    
}


@IBAction func cameraPressed(_ sender: UIButton) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
        
        
        
    }
}
