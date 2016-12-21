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

    static func animateTransitionObject(_ transitionObject : ImageScaleTransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView, usingNavigationController: Bool, animationOptions: UIViewAnimationOptions, fadeOutAnimationDelay: TimeInterval) {

        let viewEndCenter = fromViewController.view!.convert(transitionObject.viewToAnimateFrom.center, to: containerView)

        transitionObject.viewToAnimateTo.isHidden = true
        transitionObject.viewToAnimateFrom.isHidden = true

        _ = transitionObject.duration
        
        let viewToAnimateFromCopy = self.getImageFromImageScaleTransitionObject(transitionObject)
        viewToAnimateFromCopy.frame = self.startFrame(transitionObject, withNavigationController: usingNavigationController, controllerAnimatingFrom: fromViewController ,controllerAnimatingTo: toViewController)
        let viewEndFrame = self.endFrame(transitionObject, containerView: containerView).frame
        if self.endFrame(transitionObject, containerView: containerView).hasSet == false {
            viewToAnimateFromCopy.isHidden = true
        }

        
        let viewHasRoundedCorders = transitionObject.viewToAnimateFrom.layer.cornerRadius == transitionObject.viewToAnimateFrom.frame.size.height/2;
        let scaleSize = viewEndFrame.height/viewToAnimateFromCopy.frame.height
        if (viewHasRoundedCorders == true) {
            viewToAnimateFromCopy.layer.cornerRadius = viewToAnimateFromCopy.frame.size.height/2
        }

        containerView.addSubview(viewToAnimateFromCopy)

        UIView.animate(withDuration: transitionObject.duration, delay: 0, options: animationOptions, animations: {
            
            if viewHasRoundedCorders == true {
                viewToAnimateFromCopy.center = viewEndCenter
                viewToAnimateFromCopy.transform = CGAffineTransform(scaleX: scaleSize, y: scaleSize)
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

    
    static func getImageFromImageScaleTransitionObject(_ transitionObject : ImageScaleTransitionObject)->UIImageView {
        var viewToAnimateFromCopy : UIImageView!
        if let isImageInViewToAnimateFrom = transitionObject.viewToAnimateFrom.image {
            viewToAnimateFromCopy = UIImageView(image: isImageInViewToAnimateFrom.copyImage())
            viewToAnimateFromCopy.contentMode = UIViewContentMode.scaleAspectFill
        }
        
        if let isImageInViewToAnimateTo = transitionObject.viewToAnimateTo.image {
            viewToAnimateFromCopy = UIImageView(image: isImageInViewToAnimateTo.copyImage())
            viewToAnimateFromCopy.contentMode = UIViewContentMode.scaleAspectFill
        }
        
        assert(viewToAnimateFromCopy != nil, "Trying to animate with no Image")
        
        viewToAnimateFromCopy.clipsToBounds = true
        
        return viewToAnimateFromCopy
    }
    
    static func startFrame(_ transitionObject : ImageScaleTransitionObject, withNavigationController : Bool, controllerAnimatingFrom : UIViewController, controllerAnimatingTo : UIViewController)->CGRect {
        var frame = transitionObject.viewToAnimateTo.frame
        if withNavigationController == true && controllerAnimatingTo.navigationController?.navigationBar.isTranslucent == false {
            frame.origin.y += controllerAnimatingFrom.heightOfNavigationControllerAndStatusAtViewController()
        }
        return frame
        
    }
    
    static func endFrame(_ transitionObject : ImageScaleTransitionObject, containerView : UIView)->(frame : CGRect , hasSet : Bool) {
        var viewEndFrame = transitionObject.viewToAnimateFrom.frame
        if transitionObject.viewToAnimateFrom.superview != nil {
            viewEndFrame = transitionObject.viewToAnimateFrom.superview!.convert(transitionObject.viewToAnimateFrom.frame, to: containerView)
            return (viewEndFrame, true)
        } else {
            print("Error: The view you are trying to animate to in dissmess, has no super view")
        }
        return (viewEndFrame, false)
    }
}
