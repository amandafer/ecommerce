//
//  TabBarContView.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 15/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit

@IBDesignable
class ColourTab: UITabBarController {
    @IBInspectable var barBgColor: UIColor? {
        didSet {
            self.tabBar.barTintColor = barBgColor
            self.tabBar.isTranslucent = false
        }
    }
    
    @IBInspectable var textColor: UIColor? {
        didSet {
            //self.tabBar.tintColor = textColor
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: textColor!], for: .normal)
        }
    }
    
    @IBInspectable var selectedTextColor: UIColor? {
        didSet {
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedTextColor!], for: .selected)
        }
    }
}

extension UITabBar {
    // Changes the height of the Tab Bar
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 58 // wanted height
        return sizeThatFits
    }
}
