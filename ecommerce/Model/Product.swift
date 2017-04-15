//
//  PostModel.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import Foundation

class Product {
    private var _productID: String!
    private var _image: String!
    private var _name: String!
    private var _price: Double!
    private var _description: String!
    
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
    
    init(name: String, img: String, price: Double, desc: String) {
        self._name = name
        self._image = img
        self._price = price
        self._description = desc
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
    }
}
