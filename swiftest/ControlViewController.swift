//
//  ControlViewController.swift
//  swiftest
//
//  Created by Akiva Leffert on 6/15/14.
//  Copyright (c) 2014 Akiva Leffert. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

enum Shape {
    case Rectangle
    case Oval
    case Triangle
}

typealias ShapePathMap = Dictionary<Shape, () -> UIBezierPath>

class ControlViewController : UIViewController {
    
    // Don't need to import ShapeView since it's part of the same module
    @IBOutlet var shapeView : ShapeView
    
    // Declare an ivar
    let pathActions : ControlViewController -> ShapePathMap
    
    // initWithNibName:bundle: translates into init(nibName, bundle)
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        // Have to set up instance properties before calling super
        // Since pathActions is immutable (marked with a let)
        
        pathActions =  {(owner : ControlViewController) -> ShapePathMap in
            return [
                // Put these in closures since they depend on the current bounds
                Shape.Rectangle : {
                    // A closure is just an expression in braces
                    return UIBezierPath(rect:owner.shapeView.bounds)
                },
                Shape.Oval : {
                    return UIBezierPath(ovalInRect: owner.shapeView.bounds)
                },
                Shape.Triangle : {
                    let path = UIBezierPath()
                    path.moveToPoint(CGPoint(x : owner.shapeView.bounds.size.width / 2, y : 0))
                    path.addLineToPoint(CGPoint(x : 0, y : owner.shapeView.bounds.size.height))
                    path.addLineToPoint(CGPoint(x : owner.shapeView.bounds.size.width, y : owner.shapeView.bounds.size.height))
                    path.closePath()
                    
                    return path
                }
            ]
        }
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad()  {
        shapeView.shapeLayer.fillColor = UIColor.redColor().CGColor
        self.updateShapeTo(Shape.Oval)
    }
    
    func updateShapeTo(shape : Shape) {
        let path = pathActions(self)[shape]?()
        let animation = CABasicAnimation(keyPath: "path")

        // This could be objc
        animation.fromValue = shapeView.shapeLayer.path
        animation.toValue = path
        animation.duration = 1
        shapeView.shapeLayer.path = path?.CGPath
        shapeView.shapeLayer.addAnimation(animation, forKey: "pathTransition")
    }
    
    // Swift attribute syntax
    @IBAction func oval(sender : AnyObject) {
        updateShapeTo(Shape.Oval)
    }
    
    // AnyObject instead of id
    // There's also, AnyClass, AnyValue
    @IBAction func rectangle(sender : AnyObject) {
        updateShapeTo(Shape.Rectangle)
    }
    
    @IBAction func triangle(sender : AnyObject) {
        updateShapeTo(Shape.Triangle)
    }
}