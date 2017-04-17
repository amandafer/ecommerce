//
//  HomeController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 14/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var products = [Product]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    // Loads the products to the table view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        DataService.dataService.REF_PRODUCTS.observe(.value, with: { (snapshot) in
            // Gets an array of products from database
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    // For each product gets its individual data
                    if let productData = snap.value as? Dictionary<String, AnyObject> {
                        let id = snap.key
                        let product = Product(productID: id, productData: productData)
                        self.products.append(product)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    // Table view functions
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PostCellController {
            let img = product.imageUrl
            
            if let image = HomeController.imageCache.object(forKey: img as NSString) {
                cell.configureCell(product: product, img: image)
                return cell
            } else {
                cell.configureCell(product: product)
                return cell
            }
        } else {
            return PostCellController()
        }
    }
    
    // Go to determined segue when the row is pressed
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "product_details", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "product_details":
                    let productDetailController = segue.destination as! ProductDetailsController
                    
                    if let indexPath = self.tableView.indexPathForSelectedRow {
                        let product = productAtIndexPath(indexPath: indexPath as NSIndexPath)
                        let img = product.imageUrl
                        
                        if let image = HomeController.imageCache.object(forKey: img as NSString) {
                            productDetailController.configureProdDetails(product: product, img: image)
                        } else {
                            productDetailController.configureProdDetails(product: product)
                        }
                    }
                
                default: break
            }
        }
    
    }
    
    func productAtIndexPath(indexPath: NSIndexPath) -> Product {
        let prod = products[indexPath.row]
        return prod
    }
    
}
