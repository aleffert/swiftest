//
//  ShapeView.swift
//  swiftest
//
//  Created by Akiva Leffert on 6/15/14.
//  Copyright (c) 2014 Akiva Leffert. All rights reserved.
//

// Standard library imports
import Foundation
import UIKit
import QuartzCore


// 


class ShapeView : UIView {
    init(frame: CGRect)  {
        shapeLayer = CAShapeLayer()
        super.init(frame: frame)
        setup()
    }
    
    init(coder aDecoder: NSCoder!)  {
        shapeLayer = CAShapeLayer()
        super.init(coder: aDecoder)
        setup()
    }
    
    let shapeLayer : CAShapeLayer

    func setup() {
        layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews()  {
        super.layoutSubviews()
        shapeLayer.frame = bounds
    }
    
}