//
//  TableViewController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class ProfileController: UIViewController {
    @IBOutlet weak var profileImage: ImageView!
    @IBOutlet weak var usersName: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.dataService.REF_CURRENT_USER.observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? Dictionary<String, String> {
                let currentUserID = KeychainWrapper.standard.string(forKey: KEY_UID)
                
                self.user = User(userID: currentUserID!, userData: data)
                self.usersName.text = self.user.name
                
                let url = URL(string: self.user.profilePicURL)
                let data = try? Data(contentsOf: url!)
                self.profileImage.image = UIImage(data: data!)
            }
        })
    }

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
