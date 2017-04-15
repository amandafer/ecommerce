//
//  NavBarView.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 15/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit

@IBDesignable
class NavBarView: UINavigationController {
    
    @IBInspectable var isTransparent: Bool = false {
        didSet {
            if isTransparent {
                self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                self.navigationBar.shadowImage = UIImage()
                self.navigationBar.isTranslucent = true
            }
        }
    }
    
    @IBInspectable var buttonColor: UIColor? {
        didSet {
            self.navigationBar.tintColor = buttonColor
        }
    }
    
    // Changes the NavBar back button image
    /* To change the text: Storyboard > NavBar Item > change title */
    @IBInspectable var backImage: UIImage? {
        didSet {
            self.navigationBar.backIndicatorImage = backImage
            self.navigationBar.backIndicatorTransitionMaskImage = backImage
        }
    }
}
