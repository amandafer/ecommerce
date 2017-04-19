//
//  PostModel.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftKeychainWrapper

class Product {
    private var _productID: String!
    private var _image: String!
    private var _name: String!
    private var _price: Double!
    private var _description: String!
    private var _comments: Array<Any>!
    private var _prodRef: FIRDatabaseReference!
    
    var productID: String {
        return _productID
    }
    var imageUrl: String {
        return _image
    }
    var name: String {
        return _name
    }
    var price: Double {
        return _price
    }
    var description: String {
        return _description
    }
    var comments: Array<Any> {
        if _comments != nil {
            return _comments
        }
        return []
    }
    
    init(name: String, img: String, price: Double, desc: String, comments: Array<Any>) {
        self._name = name
        self._image = img
        self._price = price
        self._description = desc
        self._comments = comments
    }
    
    init(productID: String, productData: Dictionary<String, AnyObject>) {
        self._productID = productID
        
        if let name = productData["name"] as? String {
            self._name = name
        }
        if let img = productData["image"] as? String {
            self._image = img
        }
        if let price = productData["price"] as? Double {
            self._price = price
        }
        if let desc = productData["description"] as? String {
            self._description = desc
        }
        if let comments = productData["comments"] as? [[String: String]] {
            self._comments = comments as Array<Any>
        } else {
            self._comments = nil
        }
        
        _prodRef = DataService.dataService.REF_PRODUCTS.child(_productID)
    }
    
    func addComment(comment: String) {
        var dict = Dictionary<String, String>()
        dict["text"] = comment
        dict["author"] = KeychainWrapper.standard.string(forKey: KEY_UID)
            
        _comments.append(dict)
        _prodRef.child("comments").setValue(_comments)
    }
}
