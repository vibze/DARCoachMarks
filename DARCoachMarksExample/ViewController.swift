//
//  ViewController.swift
//  DARCoachMarksExample
//
//  Created by Apple on 2/16/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cmvc = ExampleCoachMarksViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cmvc.present(on: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

