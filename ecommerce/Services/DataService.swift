//
//  DataService.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import Foundation
import FirebaseDatabase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    // Creates data service singleton
    static let dataService = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_PRODUCTS = DB_BASE.child("products")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_PRODUCTS: FIRDatabaseReference {
        return _REF_PRODUCTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
