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


public class DARCoachMarksViewController: UIViewController {
    
    public weak var delegate: DARCoachMarksViewControllerDelegate?
    
    private let dimmer = DARCoachMarkDimmer()
    private var currentStep = 0
    private var currentCoachMarkView: DARCoachMarkStepView?
    
    open var dimmerGradientColors: [CGColor] {
        return [
            UIColor(red: 2/255, green: 5/255, blue: 50/255, alpha: 0.85).cgColor,
            UIColor(red: 0/255, green: 123/255, blue: 131/255, alpha: 0.85).cgColor
        ]
    }
    
    open var accentColor: UIColor {
        return UIColor.blue
    }
    
    open var userDefaultsKey: String {
        return "\(String(describing: self))_coachMarkShown"
    }
    
    open func numberOfSteps() -> Int { return 0 }
    
    open func stepAt(number: Int) -> DARCoachMarkConfig {
        return DARCoachMarkConfig()
    }
    
    public func present(on presentingView: UIView) {
        guard currentStep < numberOfSteps() else {
            dimmer.removeFromSuperview()
            return
        }
        
        presentingView.addSubview(view)
        view.backgroundColor = UIColor.clear
        view.frame = presentingView.bounds
        
        view.addSubview(dimmer)
        dimmer.gradientLayer.colors = dimmerGradientColors
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
    
    public func presentOnce(on presentingView: UIView) {
        guard UserDefaults.standard.bool(forKey: userDefaultsKey) else { return }
        present(on: presentingView)
        UserDefaults.standard.set(true, forKey: userDefaultsKey)
    }
    
    public func resetPresentedStatus() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
    
    @objc func didTapNext(_ sender: UIButton) {
        guard currentStep + 1 < numberOfSteps() else {
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
        dismiss()
    }
    
    private func showStep(index: Int) {
        currentStep = index
        let step = stepAt(number: currentStep)
        let stepView = DARCoachMarkStepView(frame: view.bounds, config: step, accentColor: accentColor)
        
        currentCoachMarkView?.removeFromSuperview()
        currentCoachMarkView = stepView
        view.addSubview(stepView)
        
        dimmer.highlightFrame(rect: step.highlightFrame, cornerRadius: step.highlightCornerRadius)
        stepView.nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        stepView.skipButton.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
        stepView.present()
    }
}
