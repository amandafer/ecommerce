//
//  ButtonsView.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 15/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonView: UIButton {
    var hasShadow: Bool = false
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
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
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if hasShadow {
            let shadowLayer = UIView(frame: self.frame)
            shadowLayer.backgroundColor = UIColor.clear
            shadowLayer.layer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
            shadowLayer.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            shadowLayer.layer.shadowOpacity = 0.5
            shadowLayer.layer.shadowRadius = 0.3
            shadowLayer.layer.masksToBounds = true
            shadowLayer.clipsToBounds = false
            
            self.superview?.addSubview(shadowLayer)
            self.superview?.bringSubview(toFront: self)
        }
    }
}
