//
//  ImageView.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 17/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit

@IBDesignable
class ImageView: UIImageView {
    var hasShadow: Bool = false
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
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
            shadowLayer.layer.shadowOpacity = 0.6
            shadowLayer.layer.shadowRadius = 3
            shadowLayer.layer.masksToBounds = true
            shadowLayer.clipsToBounds = false
            
            self.superview?.addSubview(shadowLayer)
            self.superview?.bringSubview(toFront: self)
        }
    }
}
