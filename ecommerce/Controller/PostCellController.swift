//
//  PostCellController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import FirebaseStorage

class PostCellController: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var product: Product!
    
    func configureCell(product: Product, img: UIImage? = nil) {
        self.product = product
        self.productName.text = product.name
        self.productPrice.text = String(format: "R$ %.02f", arguments: [product.price])
        
        if img != nil {
            self.productImage.image = img
        } else {
            let image = product.imageUrl
            
            // Saves each image of the product on cache
            let ref = FIRStorage.storage().reference(forURL: image)
            ref.data(withMaxSize:  4*5000*5000, completion: { (data, error) in
                if (error != nil) {
                    print("CONSOLE: Unable to download image from Firebase storage.")
                } else {
                    print("CONSOLE: Image downloaded from Firebase storage.")
                    if let imageData = data {
                        if let img = UIImage(data: imageData) {
                            self.productImage.image = img
                            HomeController.imageCache.setObject(img, forKey: image as NSString)
                        }
                    }
                }
            })
        }
    }
}
