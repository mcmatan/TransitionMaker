//
//  ImageScaleTransitionPresent.swift
//  CellOpenTransition
//
//  Created by Matan Cohen on 7/12/16.
//  Copyright © 2016 Jive. All rights reserved.
//

import Foundation
import UIKit

class ImageScaleTransitionPresent : NSObject  {

    static func animateTransitionObject(_ transitionObject : ImageScaleTransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView, animationOptions: UIViewAnimationOptions, fadeOutAnimationDelay: TimeInterval) {
        
        transitionObject.viewToAnimateTo.isHidden = true
        transitionObject.viewToAnimateFrom.isHidden = true
        
        
        var viewEndFrame = toViewController.view!.convert(transitionObject.viewToAnimateTo.frame, to: containerView)
        if let isFrameToAnimateTo = transitionObject.frameToAnimateTo {
            viewEndFrame = isFrameToAnimateTo
        }
        
        assert(transitionObject.viewToAnimateFrom.image != nil, "Trying to animate with no Image")
        
        let viewToAnimateFromCopy = UIImageView(image: transitionObject.viewToAnimateFrom.image!.copyImage())
        viewToAnimateFromCopy.contentMode = UIViewContentMode.scaleAspectFill
        
        viewToAnimateFromCopy.frame = transitionObject.viewToAnimateFrom.superview!.convert(transitionObject.viewToAnimateFrom.frame, to: containerView)
        
        viewToAnimateFromCopy.clipsToBounds = true
        
        let viewHasRoundedCorders = transitionObject.viewToAnimateFrom.layer.cornerRadius == transitionObject.viewToAnimateFrom.frame.size.height/2;
        let scaleSize = viewEndFrame.height/viewToAnimateFromCopy.frame.height
        if (viewHasRoundedCorders == true) {
            viewToAnimateFromCopy.layer.cornerRadius = viewToAnimateFromCopy.frame.size.height/2
        }
        
        containerView.addSubview(viewToAnimateFromCopy)
        
        UIView.animate(withDuration: transitionObject.duration, delay: 0, options: animationOptions, animations: {
            
            if viewHasRoundedCorders == true {
                viewToAnimateFromCopy.transform = CGAffineTransform(scaleX: scaleSize, y: scaleSize)
                viewToAnimateFromCopy.center = CGPoint(x: viewEndFrame.origin.x + (viewEndFrame.width/2), y: viewEndFrame.origin.y + (viewEndFrame.height/2))
            } else {
                viewToAnimateFromCopy.frame = viewEndFrame
            }
        }) { (finished) in}
        
        afterDelay((transitionObject.duration + fadeOutAnimationDelay)) {
            viewToAnimateFromCopy.removeFromSuperview()
            transitionObject.viewToAnimateTo.isHidden = false
            transitionObject.viewToAnimateFrom?.isHidden = false
        }
    }

}
