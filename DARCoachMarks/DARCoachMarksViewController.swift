//
//  DARCoachMarksViewController.swift
//  DARCoachMarks
//
//  Created by Viktor Ten on 2/16/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public protocol DARCoachMarksViewControllerDelegate: class {
    func darCoachMarksViewControllerDidFinish(_ controller: DARCoachMarksViewController)
}


open class DARCoachMarksViewController: UIViewController {
    
    static let shared = DARCoachMarksViewController()
    
    public weak var delegate: DARCoachMarksViewControllerDelegate?
    
    public var accentColor = UIColor.blue
    public var presenter: UIView? = UIApplication.shared.keyWindow
    
    private let dimmer = DARCoachMarkDimmer()
    private var currentCoachMarkView: DARCoachMarkStepView?
    private var queue: [DARCoachMarkConfig] = []
    private var isPresenting = false
    
    open var dimmerGradientColors: [UIColor] {
        return [
            UIColor(red: 2/255, green: 5/255, blue: 50/255, alpha: 0.85),
            UIColor(red: 0/255, green: 123/255, blue: 131/255, alpha: 0.85)
        ]
    }
    
    public func addCoachMarksToDisplay(_ coachMarks: [DARCoachMarkConfig]) {
        queue.append(contentsOf: coachMarks)
        
        if !isPresenting {
            presentCoachMarks()
        }
    }
    
    public func removeCoachMarksFromQueue(coachMarkIds: Set<String>) {
        queue = queue.filter({ !coachMarkIds.contains($0.id) })
        
        if isPresenting {
            presentNextCoachMarkInQueue()
        }
    }
    
    public func presentCoachMarks() {
        guard let presenter = presenter, queue.count > 0 else { return }
        
        isPresenting = true
        presenter.addSubview(view)
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1
        }
        
        presentNextCoachMarkInQueue()
    }
    
    public func presentNextCoachMarkInQueue() {
        if let currentCoachMarkView = currentCoachMarkView {
            currentCoachMarkView.dismiss({
                self.currentCoachMarkView?.removeFromSuperview()
                self.currentCoachMarkView = nil
                self.presentNextCoachMarkInQueue()
            })
            return
        }
        
        guard queue.count > 0 else {
            dismissCoachMarks()
            return
        }
        
        let coachMark = queue.removeFirst()
        guard !isMarkSeen(coachMark) else {
            presentNextCoachMarkInQueue()
            return
        }
        
        let coachMarkView = DARCoachMarkStepView(frame: view.frame, config: coachMark, accentColor: accentColor)
        coachMarkView.backgroundColor = .clear
        view.addSubview(coachMarkView)
        
        dimmer.highlightFrame(rect: coachMark.highlightFrame, cornerRadius: coachMark.highlightCornerRadius)
        coachMarkView.nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        coachMarkView.skipButton.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
        coachMarkView.present()
        currentCoachMarkView = coachMarkView
    }
    
    public func dismissCoachMarks() {
        isPresenting = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
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
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(dimmer)
        dimmer.gradientLayer.colors = dimmerGradientColors.map{ $0.cgColor }
        dimmer.alpha = 0
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dimmer.frame = view.bounds
        currentCoachMarkView?.frame = view.bounds
    }
    
    @objc func didTapNext(_ sender: UIButton) {
        presentNextCoachMarkInQueue()
    }
    
    @objc func didTapSkip(_ sender: UIButton) {
        queue.removeAll()
        presentNextCoachMarkInQueue()
    }
    
    private func userDefaultsKeyForMarkConfig(_ config: DARCoachMarkConfig) -> String {
        return "\(String(describing: type(of: self)))_coachMarkShown:\(config.id)"
    }
    
    private func setMarkAsSeen(_ config: DARCoachMarkConfig) {
        UserDefaults.standard.set(true, forKey: userDefaultsKeyForMarkConfig(config))
    }
    
    private func isMarkSeen(_ config: DARCoachMarkConfig) -> Bool {
        return UserDefaults.standard.bool(forKey: userDefaultsKeyForMarkConfig(config))
    }
}
