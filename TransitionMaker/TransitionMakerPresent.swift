//
//  TransitionMakerPresent.swift
//  Pods
//
//  Created by Matan Cohen on 9/4/16.
//
//

import Foundation
import UIKit

class TransitionMakerPresent : NSObject , UIViewControllerAnimatedTransitioning {
    let animationOptions = UIViewAnimationOptions.CurveEaseInOut
    var duration : NSTimeInterval!
    var transitionObjects: Array<TransitionObject>!
    let fadeOutAnimationDuration : NSTimeInterval
    let alphaZero : CGFloat = 0
    let fadeOutAnimationDelay : NSTimeInterval
    let usingNavigationController : Bool
    
    init(transitionObjects : Array<TransitionObject>, duration: NSTimeInterval, fadeOutAnimationDuration : NSTimeInterval, fadeOutAnimationDelay : NSTimeInterval, usingNavigationController : Bool) {
        self.transitionObjects  = transitionObjects
        self.fadeOutAnimationDuration = fadeOutAnimationDuration
        self.fadeOutAnimationDelay = fadeOutAnimationDelay
        self.usingNavigationController = usingNavigationController
        super.init()
        self.duration = duration
    }
    
    @objc func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    @objc func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        
        toViewController!.view.alpha = alphaZero
        containerView!.addSubview((toViewController!.view)!)
        
        if self.usingNavigationController == true && toViewController?.navigationController?.navigationBar.translucent == false {
            toViewController!.view.frame.origin.y += (toViewController?.heightOfNavigationControllerAndStatusAtViewController())!
            toViewController!.view.frame.size.height -= (toViewController?.navigationController?.navigationBar.frame.size.height)!
        }
        
        for transitionObject in self.transitionObjects {
            self.animateTransitionObject(transitionObject, fromViewController: fromViewController!, toViewController: toViewController!, containerView: containerView!)
        }
    
        
        UIView.animateWithDuration(self.duration, animations: {
            toViewController?.view.alpha = 1.0
            }, completion: { (finish) in
                transitionContext.completeTransition(true)
        })
    }
    
    
    func animateTransitionObject(transitionObject : TransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView) {
        
        switch transitionObject {
        case let imageScaleTransition as ImageScaleTransitionObject:
            ImageScaleTransitionPresent.animateTransitionObject(imageScaleTransition, fromViewController: fromViewController, toViewController: toViewController, containerView: containerView, animationOptions: animationOptions, fadeOutAnimationDelay: fadeOutAnimationDelay)
        case let crossFadeUpwards as CrossfadeUpwardTransitionObject:
            CrossfadeUpwardTransitionPresent.animateTransitionObject(crossFadeUpwards, fromViewController: fromViewController, toViewController: toViewController, containerView: containerView, animationOptions: animationOptions, fadeOutAnimationDelay: fadeOutAnimationDelay)
        default: break

        }
    }
    
}