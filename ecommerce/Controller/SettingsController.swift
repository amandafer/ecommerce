//
//  TableViewController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper

class SettingsController: UIViewController {

    @IBAction func logoutBtn(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            print("CONSOLE: Logged out")
            
            KeychainWrapper.standard.removeObject(forKey: "uid")
            performSegue(withIdentifier: "goToLogin", sender: nil)
            
        } catch let signOutError as NSError {
            print ("CONSOLE: Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
