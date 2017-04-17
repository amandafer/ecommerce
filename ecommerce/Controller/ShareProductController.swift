//
//  ShareProductController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 17/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import Social

class ShareProductController: UIViewController {
    @IBOutlet weak var shareView: ProductView!
    @IBOutlet weak var titleView: ProductView!
    
    @IBAction func shareFacebookBtn(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Share on Facebook")
            self.present(facebookSheet, animated: true, completion: nil)
        } else {
            self.shareAlert(title: "Accounts", message: "Please login to a Facebook account to share.")
        }
    }

    @IBAction func shareTwitterBtn(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Share on Twitter")
            self.present(twitterSheet, animated: true, completion: nil)
        } else {
            self.shareAlert(title: "Accounts", message: "Please login to a Twitter account to share.")
        }
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
        //location is relative to the current view
        // do something with the touched point
        if (touch?.view != shareView) && (touch?.view != titleView) {
            self.hideView()
        }
    }
    
    func hideView() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
