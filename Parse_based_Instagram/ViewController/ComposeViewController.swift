//
//  ComposeViewController.swift
//  Parse_based_Instagram
//
//  Created by Tu Pham on 10/5/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit
import Parse
class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var posetImage: UIImageView!
 
    @IBOutlet weak var captionField: UITextField!
    //tap on image to choose images from library
    //make sure to check mark "user interaction" in posetImage property, or tapping won't work.
    let vc = UIImagePickerController()
    @IBAction func Tapped(_ sender: UITapGestureRecognizer) {
        print("tapped")
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    @objc func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        //the codes from Codepath are out-of-date and not working, use these.
        let originalImage = info[.originalImage] as! UIImage
        // Do something with the images (based on your use case)
        
         posetImage.image = resizeImage(image: originalImage, newSize: CGSize(width: 20, height: 30))
        // Dismiss UIImagePickerController to go back to your original view controller
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionField.placeholder = "enter caption here"
        // Do any additional setup after loading the view.
    }
    
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        // This is the rect that we've calculated out and this is what is actually used below
        //let rect = UIImageView(x: 0, y: 0, width: newSize.width, height: newSize.height)
        let resizeImage = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImage.contentMode = UIView.ContentMode.scaleAspectFill
        resizeImage.image = image
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContext(resizeImage.frame.size)
        resizeImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    
    
    
    @IBAction func OnCancel(_ sender: AnyObject) {
       NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
        //self.performSegue(withIdentifier: "CancelSegue", sender: nil)
    }
    
    @IBAction func OnShare(_ sender: AnyObject) {
        
        Post.postUserImage(image: posetImage.image, withCaption: captionField.text) { (success, error) in
            if error != nil{
                print(error?.localizedDescription)
            }
            else{
                NotificationCenter.default.post(name: NSNotification.Name("didShared"), object: nil)
            }
        }
        
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
