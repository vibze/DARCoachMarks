//
//  ViewController.swift
//  DARCoachMarksExample
//
//  Created by Apple on 2/16/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        cmvc.present(on: self.view)
        
        case 0:
        step.text = "DAR Play — это не обычное развлекательное приложение, это образ жизни."
        step.highlightFrame = CGRect(x: view.frame.width/2 - 164, y: 173, width: 110, height: 110)
        step.highlightCornerRadius = 15
        step.hintBottom = 100
        step.arrowStartPoint = CGPoint(x: view.frame.width/2, y: 510)
        step.arrowControlPoint = CGPoint(x: view.frame.width/2 + 50, y: 173 + 110/2)
        step.arrowEndPoint = CGPoint(x: view.frame.width/2-50, y: 173 + 110/2)
        break
        case 1:
        step.text = "DAR Bazar — новая платформа сделает онлайн-торговлю невообразимо легкой для всех."
        step.highlightFrame = CGRect(x: view.frame.width/2 + 60, y: 173, width: 110, height: 110)
        step.highlightCornerRadius = 15
        step.hintBottom = 100
        step.arrowStartPoint = CGPoint(x: view.frame.width/2, y: 510)
        step.arrowControlPoint = CGPoint(x: view.frame.width/2 - 50, y: 173 + 110/2)
        step.arrowEndPoint = CGPoint(x: view.frame.width/2+50, y: 173 + 110/2)
        break
        case 2:
        step.text = "DAR VIS — это новый взгляд на оплату сервисов и перевод денег."
        step.highlightFrame = CGRect(x: view.frame.width/2 - 164, y: 353, width: 110, height: 110)
        step.highlightCornerRadius = 15
        step.hintBottom = 100
        step.arrowStartPoint = CGPoint(x: view.frame.width/2, y: 530)
        step.arrowControlPoint = CGPoint(x: view.frame.width/2, y: 353 + 110/2)
        step.arrowEndPoint = CGPoint(x: view.frame.width/2-50, y: 353 + 110/2)
        break
        case 3:
        step.text = "DAR Business — инструмент для успешного ведения бизнеса."
        step.highlightFrame = CGRect(x: view.frame.width/2 + 60, y: 353, width: 110, height: 110)
        step.highlightCornerRadius = 15
        step.hintBottom = 100
        step.arrowStartPoint = CGPoint(x: view.frame.width/2, y: 530)
        step.arrowControlPoint = CGPoint(x: view.frame.width/2, y:  353 + 110/2)
        step.arrowEndPoint = CGPoint(x: view.frame.width/2+50, y: 353 + 110/2)
        break
        */
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DARCoachMarksViewController.shared.resetPresentedStatus()
        DARCoachMarksViewController.shared.addCoachMarksToDisplay([
            DARCoachMarkConfig(id: "1", text: "DAR Play — это не обычное развлекательное приложение, это образ жизни.",
                               highlightFrame: CGRect(x: view.frame.width/2 - 164, y: 173, width: 110, height: 110),
                               highlightCornerRadius: 15, hintWidth: 300, hintBottom: 100, textBottom: 20,
                               arrowStartPoint: CGPoint(x: view.frame.width/2, y: 510),
                               arrowControlPoint: CGPoint(x: view.frame.width/2 + 50, y: 173 + 110/2),
                               arrowEndPoint: CGPoint(x: view.frame.width/2-50, y: 173 + 110/2)),
            ])
    }
}

