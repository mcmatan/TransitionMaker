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

open class TransitionMaker : NSObject , UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    var transitionObjects : Array<TransitionObject>!
    var usingNavigationController : Bool
    var duration: TimeInterval
    open var fadeOutAnimationDuration : TimeInterval = 0.1 //After animation happends, this is the fade out of the image copy.
    open var fadeOutAnimationDelayPresent : TimeInterval = 0.1 //After animation happends, this is the delay before fade out of the image, use if original image takes time to load.
    open var fadeOutAnimationDelayDismiss : TimeInterval = 0.1 //After animation happends, this is the delay before fade out of the image, use if original image takes time to load.
    
    public init(transitionObjects : Array<TransitionObject>, usingNavigationController : Bool, duration: TimeInterval) {
        self.transitionObjects = transitionObjects
        self.usingNavigationController = usingNavigationController
        self.duration = duration
    }
    
    public final func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.createImageScaleTransitionPresent()
    }
    
    public final func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.createImageScaleTransitionDismiss()
    }
    
    //MARK: Navigation controller transition
    public final func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .pop:
            return self.createImageScaleTransitionDismiss()
        case .push:
            return self.createImageScaleTransitionPresent()
        case .none:
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
