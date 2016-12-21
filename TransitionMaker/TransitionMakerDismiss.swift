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
    let animationOptions = UIViewAnimationOptions()
    var duration : TimeInterval!
    var transitionObjects: Array<TransitionObject>!
    var usingNavigationController : Bool
    let fadeOutAnimationDuration : TimeInterval
    let alphaZero : CGFloat = 0
    let fadeOutAnimationDelay : TimeInterval

    init(transitionObjects : Array<TransitionObject>, usingNavigationController : Bool, duration: TimeInterval, fadeOutAnimationDuration : TimeInterval, fadeOutAnimationDelay : TimeInterval) {
        self.transitionObjects  = transitionObjects
        self.usingNavigationController = usingNavigationController
        self.fadeOutAnimationDuration = fadeOutAnimationDuration
        self.fadeOutAnimationDelay = fadeOutAnimationDelay
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

        if self.usingNavigationController == true {
            containerView.addSubview((toViewController!.view)!)
        }

        fromViewController!.view.alpha = 1
        containerView.addSubview((fromViewController!.view)!)

        for transitionObject in self.transitionObjects {
            self.animateTransitionObject(transitionObject, fromViewController: fromViewController!, toViewController: toViewController!, containerView: containerView)
        }

        UIView.animate(withDuration: self.duration, animations: {
            fromViewController?.view.alpha = self.alphaZero
            }, completion: nil)

        afterDelay(self.duration) {
            UIView.animate(withDuration: self.duration/2, animations: {
                toViewController?.view.alpha = 1.0
                }, completion: { (finish) in
                    transitionContext.completeTransition(true)
            })
        }
    }

    func animateTransitionObject(_ transitionObject : TransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView) {

        switch transitionObject {
        case let imageScaleTransition as ImageScaleTransitionObject:
            ImageScaleTransitionDismiss.animateTransitionObject(imageScaleTransition, fromViewController: fromViewController, toViewController: toViewController, containerView: containerView, usingNavigationController: self.usingNavigationController, animationOptions: self.animationOptions, fadeOutAnimationDelay: self.fadeOutAnimationDelay)
        case let crossFadeUpwards as CrossfadeUpwardTransitionObject:
            CrossfadeUpwardTransitionDismiss.animateTransitionObject(crossFadeUpwards, fromViewController: fromViewController, toViewController: toViewController, containerView: containerView, animationOptions: animationOptions, fadeOutAnimationDelay: self.fadeOutAnimationDelay)
        default: break

        }
 }
}
