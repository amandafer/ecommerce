//
//  ProductDetailsController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 16/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import FirebaseStorage

class ProductDetailsController: UIViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDetails: UITextView!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var product: Product!
    var image: UIImage!

    override func viewDidLoad() {
        self.productImage.image = image
        self.productName.text = product.name
        self.productPrice.text = String(format: "R$ %.02f", arguments: [product.price])
        self.productDetails.text = product.description
        
        if (product.comments.count == 1) {
            self.commentLabel.text = "comment"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.numberOfComments.text = String(product.comments.count)
    }
    
    func configureProdDetails(product: Product, img: UIImage? = nil) {
        self.product = product
        
        if img != nil {
            //self.productImage.image = img
            self.image = img
        } else {
            let image = product.imageUrl
                
            // Saves each image of the product on cache
            let ref = FIRStorage.storage().reference(forURL: image)
            ref.data(withMaxSize:  2*1024*1024, completion: { (data, error) in
                if (error != nil) {
                    print("CONSOLE: Unable to download image from Firebase storage.")
                } else {
                    print("CONSOLE: Image downloaded from Firebase storage.")
                    if let imageData = data {
                        if let img = UIImage(data: imageData) {
                            //self.productImage.image = img
                            self.image = img
                            HomeController.imageCache.setObject(img, forKey: image as NSString)
                        }
                    }
                }
            })
        }
    }
    
    // Pass information to comments segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "comments":
                    let destination = segue.destination as! CommentsController
                    destination.product = product
                case "share":
                    let destination = segue.destination as! ShareProductController
                    destination.product = product
                default:
                    break
            }
        }
    }
}
