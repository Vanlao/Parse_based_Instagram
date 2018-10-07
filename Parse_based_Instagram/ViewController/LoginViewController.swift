//
//  LoginViewController.swift
//  Parse_based_Instagram
//
//  Created by Tu Pham on 9/30/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var ID_field: UITextField!   //Id text field.
    @IBOutlet weak var Password_field: UITextField! //password text field.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //Sign in button.
    @IBAction func onSignIn(_ sender: AnyObject) {
        let username = ID_field.text ?? ""  //initialize ID text field as empty.
        let password = Password_field.text ?? ""
        //fill in existing user's ID and pass.
        PFUser.logInWithUsername( inBackground: username, password: password) { (ID: PFUser?,error: Error?) in
            if ID != nil{
                print("You are now logged in.")
                //move from login screen view control to other.
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }
    
    //Sign Up button.
    @IBAction func onSignUp(_ sender: AnyObject) {
        //fill in new user's data.
        let newUser = PFUser()
        let alertController = UIAlertController(title: "ERROR", message: "Please fill in Id or password field.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
            print("OK button tapped")
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        newUser.username = ID_field.text
        newUser.password = Password_field.text
        
        //check error if username already exist.
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success{
              print("Successfully created new user!!")
                //move from login screen view control to other.
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
            else if (newUser.username!.isEmpty) || (newUser.password!.isEmpty){
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
            else{
                print(error?.localizedDescription)
                if error?._code  == 202{
                    self.present(alertController, animated: true) {
                        alertController.message = "Account already existed for this username :("
                        // optional code for what happens after the alert controller has finished presenting
                    }
                    print("Account already existed for this username :(")
                }
                
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
