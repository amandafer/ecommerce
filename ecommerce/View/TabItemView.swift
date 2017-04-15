//
//  TabBarView.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 15/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit

@IBDesignable
class TabItemView: UITabBarItem {
    @IBInspectable var finalImage:UIImage = UIImage() {
        didSet {
            self.image = finalImage.withRenderingMode(.alwaysOriginal)
        }
    }
    
    @IBInspectable var finalSelectedImage:UIImage = UIImage() {
        didSet {
            self.selectedImage = finalSelectedImage.withRenderingMode(.alwaysOriginal)
        }
    }
    
    @IBInspectable var titleHeight:CGFloat = 0.0 {
        didSet {
            self.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: titleHeight)
        }
    }
}
