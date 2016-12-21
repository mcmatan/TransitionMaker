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
    let animationOptions = UIViewAnimationOptions()
    var duration : TimeInterval!
    var transitionObjects: Array<TransitionObject>!
    let fadeOutAnimationDuration : TimeInterval
    let alphaZero : CGFloat = 0
    let fadeOutAnimationDelay : TimeInterval
    let usingNavigationController : Bool
    
    init(transitionObjects : Array<TransitionObject>, duration: TimeInterval, fadeOutAnimationDuration : TimeInterval, fadeOutAnimationDelay : TimeInterval, usingNavigationController : Bool) {
        self.transitionObjects  = transitionObjects
        self.fadeOutAnimationDuration = fadeOutAnimationDuration
        self.fadeOutAnimationDelay = fadeOutAnimationDelay
        self.usingNavigationController = usingNavigationController
        super.init()
        self.duration = duration
    }
    
    @objc func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        toViewController!.view.alpha = alphaZero
        containerView.addSubview((toViewController!.view)!)
        
        if self.usingNavigationController == true && toViewController?.navigationController?.navigationBar.isTranslucent == false {
            toViewController!.view.frame.origin.y += (toViewController?.heightOfNavigationControllerAndStatusAtViewController())!
            toViewController!.view.frame.size.height -= (toViewController?.navigationController?.navigationBar.frame.size.height)!
        }
        
        for transitionObject in self.transitionObjects {
            self.animateTransitionObject(transitionObject, fromViewController: fromViewController!, toViewController: toViewController!, containerView: containerView)
        }
    
        
        UIView.animate(withDuration: self.duration, animations: {
            toViewController?.view.alpha = 1.0
            }, completion: { (finish) in
                transitionContext.completeTransition(true)
        })
    }
    
    
    func animateTransitionObject(_ transitionObject : TransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView) {
        
        switch transitionObject {
        case let imageScaleTransition as ImageScaleTransitionObject:
            ImageScaleTransitionPresent.animateTransitionObject(imageScaleTransition, fromViewController: fromViewController, toViewController: toViewController, containerView: containerView, animationOptions: animationOptions, fadeOutAnimationDelay: fadeOutAnimationDelay)
        case let crossFadeUpwards as CrossfadeUpwardTransitionObject:
            CrossfadeUpwardTransitionPresent.animateTransitionObject(crossFadeUpwards, fromViewController: fromViewController, toViewController: toViewController, containerView: containerView, animationOptions: animationOptions, fadeOutAnimationDelay: fadeOutAnimationDelay)
        default: break

        }
    }
    
}
