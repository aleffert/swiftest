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


class ShapeView : UIView {
    
    @lazy let shapeLayer : CAShapeLayer = CAShapeLayer()
    
    init(frame: CGRect)  {
        shapeLayer = CAShapeLayer()
        super.init(frame: frame)
        setup()
    }
    
    // In theory there's only one true initializer that the other ones flow through
    // But that's not true when NSCoding gets involved
    init(coder aDecoder: NSCoder!)  {
        // Which means we have to do this in both places
        // And can't put it in a method because you can't call self methods before super.init

        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        layer.addSublayer(shapeLayer)
    }
    
    // Note the explicit override
    override func layoutSubviews()  {
        super.layoutSubviews()
        shapeLayer.frame = bounds
    }
    
}