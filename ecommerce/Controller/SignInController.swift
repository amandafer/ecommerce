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
    
    var userData = NSDictionary()

    @IBAction func signInFBBtn(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        let permissions = ["public_profile", "email"]
        
        facebookLogin.logIn(withReadPermissions: permissions, from: self) { (result, error) in
            if (error != nil) {
                print("CONSOLE: Unable to authenticate with Facebook.")
            } else if (result?.isCancelled)! {
                print("CONSOLE: User cancelled authentication with Facebook.")
            } else {
                print("CONSOLE: Logged in")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                
                // Get user data
                let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name, email, picture.type(large)"])
                graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                    if ((error) != nil) {
                        print("CONSOLE: Error retriving user's facebook data.")
                    } else {
                        self.userData = result as! NSDictionary
                    }
                })
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
                    // save the username and password to keychain
                    KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                    
                    // save the details in firebase database
                    if let name = self.userData["name"] as? String {
                        if let email = self.userData["email"] as? String {
                            
                            let url = (((self.userData.object(forKey: "picture") as AnyObject).object(forKey: "data") as AnyObject).object(forKey: "url"))
                            if let picture = url as? String {
                                let data = ["provider": credential.provider, "name": name, "email": email, "picture": picture]
                                DataService.dataService.createFirebaseDBUser(uid: user.uid, userData: data)
                                
                                self.showHomeView()
                            }
                        }
                    }
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
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
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

