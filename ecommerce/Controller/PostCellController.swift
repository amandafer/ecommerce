//
//  PostCellController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit

class PostCellController: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var product: Product!
    
    func configureCell(product: Product) {
        self.product = product
        self.productName.text = product.name
        self.productPrice.text = String(format: "R$ %.02f", arguments: [product.price])
    }
}
