//
//  ShareProductController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 17/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import Social
import FBSDKShareKit
import FirebaseStorage

class ShareProductController: UIViewController {
    @IBOutlet weak var shareView: ProductView!
    @IBOutlet weak var titleView: ProductView!
    
    var product: Product!
    var url: String!
    var imageDownloadURL: String!
    
    override func viewDidAppear(_ animated: Bool) {
        createURLs()
    }
    
    // Share product dynamic url with facebook
    @IBAction func shareFacebookBtn(_ sender: Any) {
        let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = URL(string: self.url)
        content.contentTitle = product.name
        content.contentDescription = product.description
        content.imageURL = URL(string: self.imageDownloadURL)
        FBSDKShareDialog.show(from: self, with: content as FBSDKSharingContent, delegate: nil)
    }
    
    // Share product dynamic url with twitter
    @IBAction func shareTwitterBtn(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.add(URL(fileURLWithPath: url))
            twitterSheet.setInitialText("Share on Twitter")
            self.present(twitterSheet, animated: true, completion: nil)
        } else {
            self.shareAlert(title: "Accounts", message: "Please login to Twitter or download the app to share.")
        }
    }
    
    // Create the product url and a downloadable image
    func createURLs() {
        let productID = product.productID
        url = "https://ecommerce-ec4b6.firebaseio.com/products/" + productID
        
        let gsURL = product.imageUrl
        let ref = FIRStorage.storage().reference(forURL: gsURL)
        ref.downloadURL(completion: { (URL, error) -> Void in
            if (error != nil) {
                print("CONSOLE: Unable to retrieve image downloadable URL.")
            } else {
                if let downloadURL = URL?.absoluteString {
                    self.imageDownloadURL = downloadURL
                }
            }
        })
    }
    
    
    func shareAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.hideView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if (touch?.view != shareView) && (touch?.view != titleView) {
            self.hideView()
        }
    }
    
    func hideView() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
