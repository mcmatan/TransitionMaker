//
//  CrossfadeUpwardTransitionDismiss.swift
//  Pods
//
//  Created by Matan Cohen on 9/4/16.
//
//

import Foundation
import UIKit
class CrossfadeUpwardTransitionDismiss {
    static func animateTransitionObject(transitionObject : CrossfadeUpwardTransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView, animationOptions: UIViewAnimationOptions, fadeOutAnimationDelay: NSTimeInterval) {
        
        let upwardOffset: CGFloat = 30
        
        var endFrame = transitionObject.viewToAnimateTo.frame
        endFrame.origin.y += upwardOffset
        
        UIView.animateWithDuration(transitionObject.duration, delay: 0, options: animationOptions, animations: {
            transitionObject.viewToAnimateTo.frame = endFrame
        }) { (done) in
        }
    }
}