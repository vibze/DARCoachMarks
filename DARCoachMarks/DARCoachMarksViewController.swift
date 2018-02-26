//
//  DARCoachMarksViewController.swift
//  DARCoachMarks
//
//  Created by Apple on 2/16/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public protocol DARCoachMarksViewControllerDelegate: class {
    func darCoachMarksViewControllerDidFinish(_ controller: DARCoachMarksViewController)
}


open class DARCoachMarksViewController: UIViewController {
    
    public weak var delegate: DARCoachMarksViewControllerDelegate?
    
    private let dimmer = DARCoachMarkDimmer()
    private var currentStep = 0
    private var currentCoachMarkView: DARCoachMarkStepView?
    
    open var dimmerGradientColors: [UIColor] {
        return [
            UIColor(red: 2/255, green: 5/255, blue: 50/255, alpha: 0.85),
            UIColor(red: 0/255, green: 123/255, blue: 131/255, alpha: 0.85)
        ]
    }
    
    open var accentColor: UIColor {
        return UIColor.blue
    }
    
    open func numberOfSteps() -> Int { return 0 }
    
    open func stepAt(number: Int) -> DARCoachMarkConfig {
        return DARCoachMarkConfig()
    }
    
    private var presentedSteps: [DARCoachMarkConfig] = []
    
    public func present(on presentingView: UIView, steps: [Int]? = nil) {
        presentedSteps = []
        if let steps = steps {
            for i in steps {
                guard !isStepSeen(i) else { continue }
                presentedSteps.append(stepAt(number: i))
            }
        }
        else {
            for i in 0..<numberOfSteps() {
                guard !isStepSeen(i) else { continue }
                presentedSteps.append(stepAt(number: i))
            }
        }
        
        guard currentStep < presentedSteps.count else {
            dimmer.removeFromSuperview()
            return
        }
        
        currentStep = 0
        
        presentingView.addSubview(view)
        view.backgroundColor = UIColor.clear
        view.frame = presentingView.bounds
        
        view.addSubview(dimmer)
        dimmer.gradientLayer.colors = dimmerGradientColors.map{ $0.cgColor }
        dimmer.frame = view.bounds
        dimmer.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.dimmer.alpha = 1
        }
        showStep(index: currentStep)
    }
    
    public func dismiss() {
        currentCoachMarkView?.dismiss()
        UIView.animate(withDuration: 0.3, animations: {
            self.dimmer.alpha = 0
        }, completion: { result in
            self.delegate?.darCoachMarksViewControllerDidFinish(self)
            self.view.removeFromSuperview()
        })
    }
    
    public func resetPresentedStatus() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if key.starts(with: "\(String(describing: self))_coachMarkShown") {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    @objc func didTapNext(_ sender: UIButton) {
        guard currentStep + 1 < presentedSteps.count else {
            dismiss()
            return
        }
        
        if currentCoachMarkView == nil {
            showStep(index: currentStep + 1)
        }
        else {
            currentCoachMarkView?.dismiss{
                self.showStep(index: self.currentStep + 1)
            }
        }
    }
    
    @objc func didTapSkip(_ sender: UIButton) {
        for i in 0..<numberOfSteps() {
            guard presentedSteps.contains(where: { $0.text == stepAt(number: i).text }) else { continue }
            markStepAsSeen(i)
        }
        dismiss()
    }
    
    private func userDefaultsKeyForStep(_ i: Int) -> String {
        return "\(String(describing: type(of: self)))_coachMarkShown:\(i)"
    }
    
    private func markStepAsSeen(_ i: Int) {
        print("Mark step as seen: \(userDefaultsKeyForStep(i))")
        UserDefaults.standard.set(true, forKey: userDefaultsKeyForStep(i))
    }
    
    private func isStepSeen(_ i: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: userDefaultsKeyForStep(i))
    }
    
    private func showStep(index: Int) {
        currentStep = index
        let step = presentedSteps[currentStep]
        let stepView = DARCoachMarkStepView(frame: view.bounds, config: step, accentColor: accentColor)
        
        currentCoachMarkView?.removeFromSuperview()
        currentCoachMarkView = stepView
        view.addSubview(stepView)
        
        dimmer.highlightFrame(rect: step.highlightFrame, cornerRadius: step.highlightCornerRadius)
        stepView.nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        stepView.skipButton.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
        stepView.present()
        markStepAsSeen(index)
    }
}
