//
//  ImageScaleTransitionObject.swift
//  CellOpenTransition
//
//  Created by Matan Cohen on 7/12/16.
//  Copyright © 2016 Jive. All rights reserved.
//

import Foundation
import UIKit

//Should add init for only frame, and check if all works.

public class ImageScaleTransitionObject : NSObject, TransitionObject {
    internal var viewToAnimateFrom : UIImageView!
    internal var frameToAnimateTo : CGRect?
    internal var viewToAnimateTo :UIImageView // This is optional, if you do require this, your view will be hidden/unhidden to suite the transition better.
    internal var duration : NSTimeInterval
    
    
    public init(viewToAnimateFrom : UIImageView, viewToAnimateTo: UIImageView, duration : NSTimeInterval, frameToAnimateTo : CGRect) {
        self.viewToAnimateFrom = viewToAnimateFrom
        self.frameToAnimateTo = frameToAnimateTo
        self.viewToAnimateTo = viewToAnimateTo
        self.duration = duration
    }
    
    public init(viewToAnimateFrom : UIImageView, viewToAnimateTo: UIImageView, duration : NSTimeInterval) {
        self.viewToAnimateFrom = viewToAnimateFrom
        self.viewToAnimateTo = viewToAnimateTo
        self.duration = duration
    }
    
//    internal static func  transitionForOperation(operation: UINavigationControllerOperation, transitionObjects : Array<ImageScaleTransitionObject>, usingNavigationController : Bool, duration: NSTimeInterval, fadeOutAnimationDuration : NSTimeInterval, fadeOutAnimationDelay : NSTimeInterval, fromViewController: UIViewController)->UIViewControllerAnimatedTransitioning {
//        
//        switch operation {
//        case .Pop:
//            return ImageScaleTransitionObject.createImageScaleTransitionDismiss(transitionObjects, usingNavigationController: usingNavigationController, duration: duration, fadeOutAnimationDuration: fadeOutAnimationDuration, fadeOutAnimationDelay: fadeOutAnimationDelay)
//        case .Push:
//            return ImageScaleTransitionObject.createImageScaleTransitionPresent(transitionObjects, usingNavigationController: usingNavigationController, duration: duration, fadeOutAnimationDuration: fadeOutAnimationDuration, fadeOutAnimationDelay: fadeOutAnimationDelay, fromViewController: fromViewController)
//        }
//    }
//    
//    internal static func createImageScaleTransitionDismiss(transitionObjects : Array<ImageScaleTransitionObject>, usingNavigationController : Bool, duration: NSTimeInterval, fadeOutAnimationDuration : NSTimeInterval, fadeOutAnimationDelay : NSTimeInterval)->ImageScaleTransitionDismiss {
//        return  ImageScaleTransitionDismiss(transitionObjects: transitionObjects, usingNavigationController: usingNavigationController, duration : duration, fadeOutAnimationDuration : fadeOutAnimationDuration, fadeOutAnimationDelay : fadeOutAnimationDelay)
//    }
//    
//    internal static func createImageScaleTransitionPresent(transitionObjects : Array<ImageScaleTransitionObject>, usingNavigationController : Bool, duration: NSTimeInterval, fadeOutAnimationDuration : NSTimeInterval, fadeOutAnimationDelay : NSTimeInterval, fromViewController: UIViewController)->ImageScaleTransitionPresent {
//        return ImageScaleTransitionPresent(transitionObjects: transitionObjects, duration : duration, fadeOutAnimationDuration : fadeOutAnimationDuration, fadeOutAnimationDelay: fadeOutAnimationDelay, usingNavigationController: usingNavigationController)
//    }
    
}