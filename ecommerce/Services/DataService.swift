//
//  DataService.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    // Creates data service singleton
    static let dataService = DataService()
    
    // DB references
    private var _REF_BASE = DB_BASE
    private var _REF_PRODUCTS = DB_BASE.child("products")
    private var _REF_USERS = DB_BASE.child("users")
    
    // Storage references
    private var _REF_PROD_IMGS = STORAGE_BASE.child("products-imgs")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_PRODUCTS: FIRDatabaseReference {
        return _REF_PRODUCTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_CURRENT_USER: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    var REF_PROD_IMGS: FIRStorageReference {
        return _REF_PROD_IMGS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
