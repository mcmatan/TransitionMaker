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
//    let animationOptions = UIViewAnimationOptions.CurveEaseInOut
//    var duration : NSTimeInterval!
//    var transitionObjects: Array<ImageScaleTransitionObject>!
//    let fadeOutAnimationDuration : NSTimeInterval
//    let alphaZero : CGFloat = 0
//    let fadeOutAnimationDelay : NSTimeInterval
//    let usingNavigationController : Bool
//    
//    init(transitionObjects : Array<ImageScaleTransitionObject>, duration: NSTimeInterval, fadeOutAnimationDuration : NSTimeInterval, fadeOutAnimationDelay : NSTimeInterval, usingNavigationController : Bool) {
//        self.transitionObjects  = transitionObjects
//        self.fadeOutAnimationDuration = fadeOutAnimationDuration
//        self.fadeOutAnimationDelay = fadeOutAnimationDelay
//        self.usingNavigationController = usingNavigationController
//        super.init()
//        self.duration = duration
//    }
//    
//    @objc func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
//        return self.duration
//    }
//    
//    @objc func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
//        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
//        let containerView = transitionContext.containerView()
//        
//        toViewController!.view.alpha = alphaZero
//        containerView!.addSubview((toViewController!.view)!)
//        
//        if self.usingNavigationController == true && toViewController?.navigationController?.navigationBar.translucent == false {
//            toViewController!.view.frame.origin.y += (toViewController?.heightOfNavigationControllerAndStatusAtViewController())!
//            toViewController!.view.frame.size.height -= (toViewController?.navigationController?.navigationBar.frame.size.height)!
//        }
//        
//        for transitionObject in self.transitionObjects {
//            self.animateTransitionObject(transitionObject, fromViewController: fromViewController!, toViewController: toViewController!, containerView: containerView!)
//        }
//        
//    }
//    
//
//    func animateTransitionObject(transitionObject : ImageScaleTransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView) {
//        
//        transitionObject.viewToAnimateTo.hidden = true
//        transitionObject.viewToAnimateFrom.hidden = true
//    
//        
//        var viewEndFrame = toViewController.view!.convertRect(transitionObject.viewToAnimateTo.frame, toView: containerView)
//        if let isFrameToAnimateTo = transitionObject.frameToAnimateTo {
//            viewEndFrame = isFrameToAnimateTo
//        }
//        
//        
//    
//        assert(transitionObject.viewToAnimateFrom.image != nil, "Trying to animate with no Image")
//        
//        let viewToAnimateFromCopy = UIImageView(image: transitionObject.viewToAnimateFrom.image!.copyMe())
//        viewToAnimateFromCopy.contentMode = UIViewContentMode.ScaleAspectFill
//        
//        viewToAnimateFromCopy.frame = transitionObject.viewToAnimateFrom.superview!.convertRect(transitionObject.viewToAnimateFrom.frame, toView: containerView)
//        
//        viewToAnimateFromCopy.clipsToBounds = true
//        
//        let viewHasRoundedCorders = transitionObject.viewToAnimateFrom.layer.cornerRadius == transitionObject.viewToAnimateFrom.frame.size.height/2;
//        let scaleSize = viewEndFrame.height/viewToAnimateFromCopy.frame.height
//        if (viewHasRoundedCorders == true) {
//            viewToAnimateFromCopy.layer.cornerRadius = viewToAnimateFromCopy.frame.size.height/2
//        }
//        
//        containerView.addSubview(viewToAnimateFromCopy)
//        
//        UIView.animateWithDuration(transitionObject.duration, delay: 0, options: animationOptions, animations: {
//            
//            if viewHasRoundedCorders == true {
//                viewToAnimateFromCopy.transform = CGAffineTransformMakeScale(scaleSize, scaleSize)
//                viewToAnimateFromCopy.center = CGPointMake(viewEndFrame.origin.x + (viewEndFrame.width/2), viewEndFrame.origin.y + (viewEndFrame.height/2))
//            } else {
//                viewToAnimateFromCopy.frame = viewEndFrame
//            }
//        }) { (finished) in}
//        
//        afterDelay((transitionObject.duration + fadeOutAnimationDelay)) { 
//            viewToAnimateFromCopy.removeFromSuperview()
//            transitionObject.viewToAnimateTo.hidden = false
//            transitionObject.viewToAnimateFrom?.hidden = false
//        }
//
//    }
    
    static func animateTransitionObject(transitionObject : ImageScaleTransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView, animationOptions: UIViewAnimationOptions, fadeOutAnimationDelay: NSTimeInterval) {
        
        transitionObject.viewToAnimateTo.hidden = true
        transitionObject.viewToAnimateFrom.hidden = true
        
        
        var viewEndFrame = toViewController.view!.convertRect(transitionObject.viewToAnimateTo.frame, toView: containerView)
        if let isFrameToAnimateTo = transitionObject.frameToAnimateTo {
            viewEndFrame = isFrameToAnimateTo
        }
        
        assert(transitionObject.viewToAnimateFrom.image != nil, "Trying to animate with no Image")
        
        let viewToAnimateFromCopy = UIImageView(image: transitionObject.viewToAnimateFrom.image!.copyMe())
        viewToAnimateFromCopy.contentMode = UIViewContentMode.ScaleAspectFill
        
        viewToAnimateFromCopy.frame = transitionObject.viewToAnimateFrom.superview!.convertRect(transitionObject.viewToAnimateFrom.frame, toView: containerView)
        
        viewToAnimateFromCopy.clipsToBounds = true
        
        let viewHasRoundedCorders = transitionObject.viewToAnimateFrom.layer.cornerRadius == transitionObject.viewToAnimateFrom.frame.size.height/2;
        let scaleSize = viewEndFrame.height/viewToAnimateFromCopy.frame.height
        if (viewHasRoundedCorders == true) {
            viewToAnimateFromCopy.layer.cornerRadius = viewToAnimateFromCopy.frame.size.height/2
        }
        
        containerView.addSubview(viewToAnimateFromCopy)
        
        UIView.animateWithDuration(transitionObject.duration, delay: 0, options: animationOptions, animations: {
            
            if viewHasRoundedCorders == true {
                viewToAnimateFromCopy.transform = CGAffineTransformMakeScale(scaleSize, scaleSize)
                viewToAnimateFromCopy.center = CGPointMake(viewEndFrame.origin.x + (viewEndFrame.width/2), viewEndFrame.origin.y + (viewEndFrame.height/2))
            } else {
                viewToAnimateFromCopy.frame = viewEndFrame
            }
        }) { (finished) in}
        
        afterDelay((transitionObject.duration + fadeOutAnimationDelay)) {
            viewToAnimateFromCopy.removeFromSuperview()
            transitionObject.viewToAnimateTo.hidden = false
            transitionObject.viewToAnimateFrom?.hidden = false
        }
    }

}