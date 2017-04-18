//
//  User.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 17/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import Foundation

class User {
    private var _userID: String!
    private var _name: String!
    private var _email: String!
    private var _profilePicture: String!
    private var _provider: String!
    
    var userID: String {
        return _userID
    }
    var name: String {
        return _name
    }
    var email: String {
        return _email
    }
    var profilePicURL: String {
        return _profilePicture
    }
    var provider: String {
        return _provider
    }
    
    
    init(name: String, img: String, email: String, provider: String) {
        self._name = name
        self._profilePicture = img
        self._email = email
        self._provider = provider
    }
    
    
    init(userID: String, userData: Dictionary<String, String>) {
        self._userID = userID
        
        if let name = userData["name"] {
            self._name = name
        }
        if let img = userData["picture"] {
            self._profilePicture = img
        }
        if let email = userData["email"] {
            self._email = email
        }
        if let provider = userData["provider"] {
            self._provider = provider
        }
    }
}
