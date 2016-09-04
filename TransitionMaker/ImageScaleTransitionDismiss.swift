//
//  ImageScaleTransitionDismiss.swift
//  CellOpenTransition
//
//  Created by Matan Cohen on 7/12/16.
//  Copyright © 2016 Jive. All rights reserved.
//

import Foundation
import UIKit

class ImageScaleTransitionDismiss : NSObject  {

    static func animateTransitionObject(transitionObject : ImageScaleTransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView, usingNavigationController: Bool, animationOptions: UIViewAnimationOptions, fadeOutAnimationDelay: NSTimeInterval) {

        let viewEndCenter = fromViewController.view!.convertPoint(transitionObject.viewToAnimateFrom.center, toView: containerView)

        transitionObject.viewToAnimateTo.hidden = true
        transitionObject.viewToAnimateFrom.hidden = true

        let animationDuration = transitionObject.duration
        
        var viewToAnimateFromCopy = self.getImageFromImageScaleTransitionObject(transitionObject)
        viewToAnimateFromCopy.frame = self.startFrame(transitionObject, withNavigationController: usingNavigationController, controllerAnimatingFrom: fromViewController ,controllerAnimatingTo: toViewController)
        var viewEndFrame = self.endFrame(transitionObject, containerView: containerView).frame
        if self.endFrame(transitionObject, containerView: containerView).hasSet == false {
            viewToAnimateFromCopy.hidden = true
        }

        
        let viewHasRoundedCorders = transitionObject.viewToAnimateFrom.layer.cornerRadius == transitionObject.viewToAnimateFrom.frame.size.height/2;
        let scaleSize = viewEndFrame.height/viewToAnimateFromCopy.frame.height
        if (viewHasRoundedCorders == true) {
            viewToAnimateFromCopy.layer.cornerRadius = viewToAnimateFromCopy.frame.size.height/2
        }

        containerView.addSubview(viewToAnimateFromCopy)

        UIView.animateWithDuration(transitionObject.duration, delay: 0, options: animationOptions, animations: {
            
            if viewHasRoundedCorders == true {
                viewToAnimateFromCopy.center = viewEndCenter
                viewToAnimateFromCopy.transform = CGAffineTransformMakeScale(scaleSize, scaleSize)
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

    
    static func getImageFromImageScaleTransitionObject(transitionObject : ImageScaleTransitionObject)->UIImageView {
        var viewToAnimateFromCopy : UIImageView!
        if let isImageInViewToAnimateFrom = transitionObject.viewToAnimateFrom.image {
            viewToAnimateFromCopy = UIImageView(image: isImageInViewToAnimateFrom.copyMe())
            viewToAnimateFromCopy.contentMode = UIViewContentMode.ScaleAspectFill
        }
        
        if let isImageInViewToAnimateTo = transitionObject.viewToAnimateTo.image {
            viewToAnimateFromCopy = UIImageView(image: isImageInViewToAnimateTo.copyMe())
            viewToAnimateFromCopy.contentMode = UIViewContentMode.ScaleAspectFill
        }
        
        assert(viewToAnimateFromCopy != nil, "Trying to animate with no Image")
        
        viewToAnimateFromCopy.clipsToBounds = true
        
        return viewToAnimateFromCopy
    }
    
    static func startFrame(transitionObject : ImageScaleTransitionObject, withNavigationController : Bool, controllerAnimatingFrom : UIViewController, controllerAnimatingTo : UIViewController)->CGRect {
        var frame = transitionObject.viewToAnimateTo.frame
        if withNavigationController == true && controllerAnimatingTo.navigationController?.navigationBar.translucent == false {
            frame.origin.y += controllerAnimatingFrom.heightOfNavigationControllerAndStatusAtViewController()
        }
        return frame
        
    }
    
    static func endFrame(transitionObject : ImageScaleTransitionObject, containerView : UIView)->(frame : CGRect , hasSet : Bool) {
        var viewEndFrame = transitionObject.viewToAnimateFrom.frame
        if let fromViewSuperExists = transitionObject.viewToAnimateFrom.superview {
            viewEndFrame = transitionObject.viewToAnimateFrom.superview!.convertRect(transitionObject.viewToAnimateFrom.frame, toView: containerView)
            return (viewEndFrame, true)
        } else {
            print("Error: The view you are trying to animate to in dissmess, has no super view")
        }
        return (viewEndFrame, false)
    }
}
