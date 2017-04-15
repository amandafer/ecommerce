//
//  ProductView.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 15/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit

let GRAY_COLOUR: CGFloat = 226.0/255.0

@IBDesignable
class ProductView: UIView {
    var hasShadow: Bool = false
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var bottomBorderColor: UIColor = UIColor(red: GRAY_COLOUR, green: GRAY_COLOUR, blue: GRAY_COLOUR, alpha: 1)
    @IBInspectable var bottomBorderHeight: CGFloat = 0 {
        didSet {
            let bottomBorder = CALayer()
            bottomBorder.backgroundColor = bottomBorderColor.cgColor;
            bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - bottomBorderHeight, width: self.frame.size.width, height: bottomBorderHeight)
            self.layer.addSublayer(bottomBorder)
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if hasShadow {
            let shadowLayer = UIView(frame: self.frame)
            shadowLayer.backgroundColor = UIColor.clear
            shadowLayer.layer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
            shadowLayer.layer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.layer.shadowOpacity = 0.5
            shadowLayer.layer.shadowRadius = 2
            shadowLayer.layer.masksToBounds = true
            shadowLayer.clipsToBounds = false
        
            self.superview?.addSubview(shadowLayer)
            self.superview?.bringSubview(toFront: self)
        }
    }
}
