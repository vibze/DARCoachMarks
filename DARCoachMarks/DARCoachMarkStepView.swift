//
//  DARCoachMarkStepView.swift
//  DARCoachMarks
//
//  Created by Apple on 2/19/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class DARCoachMarkStepView: UIView {
    
    private let config: DARCoachMarkConfig
    let textLabel = UILabel()
    let nextButton = UIButton()
    let skipButton = UIButton()
    
    private let accentColor: UIColor
    private let animationDuration: Double = 0.3
    private let drawLayer = CALayer()
    private let lineLayer = CAShapeLayer()
    private let arrowLayer = CAShapeLayer()
    
    init(frame: CGRect, config: DARCoachMarkConfig, accentColor: UIColor) {
        self.config = config
        self.accentColor = accentColor
        super.init(frame: frame)
        
        layer.addSublayer(drawLayer)
        addSubview(textLabel)
        addSubview(nextButton)
        addSubview(skipButton)
        
        textLabel.text = config.text
        textLabel.textColor = UIColor.white
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.textAlignment = .center
        skipButton.accessibilityIdentifier = "DARCoachMarks.SkipButton"
        skipButton.setTitle("Пропустить все", for: .normal)
        skipButton.setTitleColor(accentColor, for: .normal)
        nextButton.accessibilityIdentifier = "DARCoachMarks.NextButton"
        nextButton.setTitle("Далее", for: .normal)
        nextButton.backgroundColor = accentColor
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        nextButton.layer.cornerRadius = 10
        
        textLabel.alpha = 0
        skipButton.alpha = 0
        nextButton.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonWidth: CGFloat = config.hintWidth * 0.8
        
        skipButton.frame = CGRect(x: frame.width/2 - buttonWidth/2, y: frame.height - config.hintBottom - 44, width: buttonWidth, height: 44)
        nextButton.frame = CGRect(x: frame.width/2 - buttonWidth/2, y: skipButton.frame.minY - 44 - 10, width: buttonWidth, height: 44)
        
        let textSize = textLabel.sizeThatFits(CGSize(width: config.hintWidth, height: CGFloat.greatestFiniteMagnitude))
        textLabel.frame = CGRect(x: frame.width/2 - config.hintWidth/2, y: nextButton.frame.minY - textSize.height - config.textBottom, width: config.hintWidth, height: textSize.height)
        
        drawLayer.frame = bounds
    }
    
    func present() {
        drawArrow(from: config.arrowStartPoint, to: config.arrowEndPoint, controlPoint: config.arrowControlPoint)
        
        UIView.animate(withDuration: animationDuration) {
            self.textLabel.alpha = 1
            self.skipButton.alpha = 1
            self.nextButton.alpha = 1
        }
    }
    
    func dismiss(_ completion: (() -> Void)? = nil) {
        eraseArrow()
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.textLabel.alpha = 0
            self.skipButton.alpha = 0
            self.nextButton.alpha = 0
        }, completion: { result in
            completion?()
        })
    }
    
    private func drawArrow(from startPoint: CGPoint, to endPoint: CGPoint, controlPoint: CGPoint) {
        
        let lineColor = accentColor.cgColor
        let lineWidth: CGFloat = 1.5
        let arrowSize: CGFloat = 5
        
        let lineFinalPath = UIBezierPath()
        lineFinalPath.move(to: startPoint)
        lineFinalPath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        lineLayer.path = lineFinalPath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.lineWidth = lineWidth
        lineLayer.lineCap = kCALineCapRound
        lineLayer.strokeColor = lineColor
        
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x: 0, y: 0))
        arrowPath.addLine(to: CGPoint(x: -arrowSize, y: arrowSize))
        arrowPath.move(to: CGPoint(x: 0, y: 0))
        arrowPath.addLine(to: CGPoint(x: -arrowSize, y: -arrowSize))
        
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.strokeColor = lineColor
        arrowLayer.lineWidth = lineWidth
        arrowLayer.lineCap = kCALineCapRound
        
        let angle = atan2f(Float(endPoint.y - controlPoint.y), Float(endPoint.x - controlPoint.x))
        arrowLayer.transform = CATransform3DMakeRotation(CGFloat(angle), 0, 0, 1)
        
        drawLayer.addSublayer(lineLayer)
        arrowLayer.frame = bounds
        
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.fromValue = 0
        anim.toValue = 1
        anim.repeatCount = 1
        anim.duration = animationDuration
        lineLayer.add(anim, forKey: "path")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationDuration) {
            self.lineLayer.addSublayer(self.arrowLayer)
            self.arrowLayer.frame = CGRect(x: endPoint.x, y: endPoint.y, width: 0, height: 0)
        }
    }
    
    private func eraseArrow() {
        let anim = CABasicAnimation(keyPath: "strokeStart")
        anim.fromValue = 0
        anim.toValue = 1
        anim.repeatCount = 1
        anim.duration = animationDuration
        lineLayer.add(anim, forKey: "path")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationDuration) {
            self.arrowLayer.removeFromSuperlayer()
        }
    }
}
