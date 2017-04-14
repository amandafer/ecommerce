//
//  ViewController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class SignInController: UIViewController {

    @IBAction func signInFBBtn(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        let permissions = ["email"]
        
        facebookLogin.logIn(withReadPermissions: permissions, from: self) { (result, error) in
            if (error != nil) {
                print("Unable to authenticate with Facebook.")
            } else if (result?.isCancelled)! {
                print("User cancelled authentication with Facebook.")
            } else {
                print("Logged in")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if (error != nil) {
                print("Unable to authenticate with Firebase.")
            } else {
                print("Successufully authenticated with Firebase.")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

