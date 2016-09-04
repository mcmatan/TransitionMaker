//
//  ImageOpenTransition.swift
//  CellOpenTransition
//
//  Created by Matan Cohen on 7/12/16.
//  Copyright © 2016 Jive. All rights reserved.
//

import Foundation
import UIKit

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////


 * ImageScaleTransitionObjects should be inserted in an array, first is lowest as subview, and the last object will be the top subview
 
 * UIImageView - view to translate from, has to be:
  imageView.contentMode = UIViewContentMode.ScaleAspectFill
  imageView.clipsToBounds = true


////////////////////////////////////////////////////////////////////////////////////////////////////////
 */

public class TransitionMaker : NSObject , UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    var transitionObjects : Array<TransitionObject>!
    var usingNavigationController : Bool
    var duration: NSTimeInterval
    public var fadeOutAnimationDuration : NSTimeInterval = 0.1 //After animation happends, this is the fade out of the image copy.
    public var fadeOutAnimationDelayPresent : NSTimeInterval = 0.1 //After animation happends, this is the delay before fade out of the image, use if original image takes time to load.
    public var fadeOutAnimationDelayDismiss : NSTimeInterval = 0.1 //After animation happends, this is the delay before fade out of the image, use if original image takes time to load.
    
    public init(transitionObjects : Array<TransitionObject>, usingNavigationController : Bool, duration: NSTimeInterval) {
        self.transitionObjects = transitionObjects
        self.usingNavigationController = usingNavigationController
        self.duration = duration
    }
    
    public final func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.createImageScaleTransitionPresent()
    }
    
    public final func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.createImageScaleTransitionDismiss()
    }
    
    //MARK: Navigation controller transition
    public final func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .Pop:
            return self.createImageScaleTransitionDismiss()
        case .Push:
            return self.createImageScaleTransitionPresent()
        case .None:
            return nil
        }
    }
    
    internal func createImageScaleTransitionPresent()->TransitionMakerPresent {
        return TransitionMakerPresent(transitionObjects: self.transitionObjects, duration: self.duration, fadeOutAnimationDuration: self.fadeOutAnimationDuration, fadeOutAnimationDelay: self.fadeOutAnimationDuration, usingNavigationController: self.usingNavigationController)
    }
    
    internal func createImageScaleTransitionDismiss()->TransitionMakerDismiss {
        return TransitionMakerDismiss(transitionObjects: transitionObjects, usingNavigationController: self.usingNavigationController, duration: self.duration, fadeOutAnimationDuration: self.fadeOutAnimationDuration, fadeOutAnimationDelay: self.fadeOutAnimationDelayDismiss)
    }
}