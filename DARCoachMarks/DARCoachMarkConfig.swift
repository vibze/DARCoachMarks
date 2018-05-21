//
//  DARCoachMarkConfig.swift
//  DARCoachMarks
//
//  Created by Apple on 2/19/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public struct DARCoachMarkConfig {
    
    var id: String
    
    public var text = ""
    public var highlightFrame = CGRect(x: 0, y: 0, width: 60, height: 60)
    public var highlightCornerRadius: CGFloat = 5
    public var hintWidth: CGFloat = 300
    public var hintBottom: CGFloat = 0
    public var textBottom: CGFloat = 20
    public var arrowStartPoint = CGPoint(x: 0, y: 0)
    public var arrowControlPoint = CGPoint(x: 0, y: 0)
    public var arrowEndPoint = CGPoint(x: 0, y: 0)
}
