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
import SwiftKeychainWrapper

class SignInController: UIViewController {

    @IBAction func signInFBBtn(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        let permissions = ["email"]
        
        facebookLogin.logIn(withReadPermissions: permissions, from: self) { (result, error) in
            if (error != nil) {
                print("CONSOLE: Unable to authenticate with Facebook.")
            } else if (result?.isCancelled)! {
                print("CONSOLE: User cancelled authentication with Facebook.")
            } else {
                print("CONSOLE: Logged in")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                self.showHomeView()
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if (error != nil) {
                print("CONSOLE: Unable to authenticate with Firebase.")
            } else {
                print("CONSOLE: Successufully authenticated with Firebase.")
                // Sets the keychain
                if let user = user {
                    // save the details in firebase database
                    let userData = ["provider": credential.provider]
                    DataService.dataService.createFirebaseDBUser(uid: user.uid, userData: userData)
                    
                    // save the username and password to keychain
                    KeychainWrapper.standard.set(user.uid, forKey: "uid")
                }
            }
        })
    }
    
    func showHomeView() {
        performSegue(withIdentifier: "home", sender: nil)
        /* Table view doesnt work when user log in
        let protectedPage = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = protectedPageNav
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            self.showHomeView()
        }
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

