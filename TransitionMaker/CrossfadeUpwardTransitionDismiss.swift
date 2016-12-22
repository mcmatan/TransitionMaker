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
    static func animateTransitionObject(_ transitionObject : CrossfadeUpwardTransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView, animationOptions: UIViewAnimationOptions, fadeOutAnimationDelay: TimeInterval) {
        
        let upwardOffset: CGFloat = 30
        
        containerView.bringSubview(toFront: transitionObject.viewToAnimateTo)
        
        var finalFrame = toViewController.view!.convert(transitionObject.viewToAnimateTo.frame, to: containerView)
        if let isFrameToAnimateTo = transitionObject.frameToAnimateTo {
            finalFrame = isFrameToAnimateTo
        }
        
        var startFrame = finalFrame
        startFrame.origin.y += upwardOffset
        
        
        let viewCopy = transitionObject.viewToAnimateTo.copyView()
        containerView.addSubview(viewCopy)
        viewCopy.frame = finalFrame
        viewCopy.alpha = 1
        
        transitionObject.viewToAnimateTo.isHidden = true
        
        UIView.animate(withDuration: transitionObject.duration, delay: 0, options: animationOptions, animations: {
            
            viewCopy.frame = startFrame
            viewCopy.alpha = 0
        }) { (done) in
            viewCopy.removeFromSuperview()
        }
    }
}
