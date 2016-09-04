//
//  CrossfadeUpwardTransitionPresent.swift
//  Pods
//
//  Created by Matan Cohen on 9/4/16.
//
//

import Foundation
import UIKit

class CrossfadeUpwardTransitionPresent: NSObject {
    static func animateTransitionObject(transitionObject : CrossfadeUpwardTransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView, animationOptions: UIViewAnimationOptions, fadeOutAnimationDelay: NSTimeInterval) {
        
//        var startingFrame = toViewController.view!.convertRect(transitionObject.viewToAnimateTo.frame, toView: containerView)
//        if let isFrameToAnimateTo = transitionObject.frameToAnimateTo {
//            startingFrame = isFrameToAnimateTo
//        }
        
        let upwardOffset: CGFloat = 30
        
        var originalFrame = transitionObject.viewToAnimateTo.frame
        var startingFrame = originalFrame
        startingFrame.origin.y += upwardOffset
        transitionObject.viewToAnimateTo.frame = startingFrame

        UIView.animateWithDuration(transitionObject.duration, delay: 0, options: animationOptions, animations: { 
            transitionObject.viewToAnimateTo.frame = originalFrame
            }) { (done) in
        }
    }
}