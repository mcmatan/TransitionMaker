//
//  TransitionMakerDismiss.swift
//  Pods
//
//  Created by Matan Cohen on 9/4/16.
//
//

import Foundation
import UIKit

class TransitionMakerDismiss : NSObject , UIViewControllerAnimatedTransitioning {
    let animationOptions = UIViewAnimationOptions.CurveEaseInOut
    var duration : NSTimeInterval!
    var transitionObjects: Array<TransitionObject>!
    var usingNavigationController : Bool
    let fadeOutAnimationDuration : NSTimeInterval
    let alphaZero : CGFloat = 0
    let fadeOutAnimationDelay : NSTimeInterval

    init(transitionObjects : Array<TransitionObject>, usingNavigationController : Bool, duration: NSTimeInterval, fadeOutAnimationDuration : NSTimeInterval, fadeOutAnimationDelay : NSTimeInterval) {
        self.transitionObjects  = transitionObjects
        self.usingNavigationController = usingNavigationController
        self.fadeOutAnimationDuration = fadeOutAnimationDuration
        self.fadeOutAnimationDelay = fadeOutAnimationDelay
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

        if self.usingNavigationController == true {
            containerView!.addSubview((toViewController!.view)!)
        }

        fromViewController!.view.alpha = 1
        containerView!.addSubview((fromViewController!.view)!)

        for transitionObject in self.transitionObjects {
            self.animateTransitionObject(transitionObject, fromViewController: fromViewController!, toViewController: toViewController!, containerView: containerView!)
        }

        UIView.animateWithDuration(self.duration, animations: {
            fromViewController?.view.alpha = self.alphaZero
            }, completion: nil)

        afterDelay(self.duration) {
            UIView.animateWithDuration(self.duration/2, animations: {
                toViewController?.view.alpha = 1.0
                }, completion: { (finish) in
                    transitionContext.completeTransition(true)
            })
        }
    }

    func animateTransitionObject(transitionObject : TransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView) {

        switch transitionObject {
        case let imageScaleTransition as ImageScaleTransitionObject:
            ImageScaleTransitionDismiss.animateTransitionObject(imageScaleTransition, fromViewController: fromViewController, toViewController: toViewController, containerView: containerView, usingNavigationController: self.usingNavigationController, animationOptions: self.animationOptions, fadeOutAnimationDelay: self.fadeOutAnimationDelay)
        case let crossFadeUpwards as CrossfadeUpwardTransitionObject:
            CrossfadeUpwardTransitionDismiss.animateTransitionObject(crossFadeUpwards, fromViewController: fromViewController, toViewController: toViewController, containerView: containerView, animationOptions: animationOptions, fadeOutAnimationDelay: self.fadeOutAnimationDelay)
        default: break

        }
 }
}
