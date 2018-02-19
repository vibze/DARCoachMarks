//
//  DARCoachMarkDimmer.swift
//  DARCoachMarks
//
//  Created by Apple on 2/19/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class DARCoachMarkDimmer: UIView {
    
    let gradientLayer = CAGradientLayer()
    let dimmerMaskLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(gradientLayer)
        gradientLayer.mask = dimmerMaskLayer
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.8).cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.15, y: 1.05)
        gradientLayer.endPoint = CGPoint(x: 1.15, y: -0.3)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = bounds
    }
    
    func highlightFrame(rect: CGRect, cornerRadius: CGFloat) {
        let dimmerMaskPath = CGMutablePath()
        dimmerMaskPath.addRect(bounds)
        dimmerMaskPath.addPath(CGPath(roundedRect: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil))
        dimmerMaskLayer.path = dimmerMaskPath
        dimmerMaskLayer.fillRule = kCAFillRuleEvenOdd
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
