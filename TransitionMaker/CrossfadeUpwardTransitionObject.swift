//
//  CrossfadeUpwardTransitionObject.swift
//  Pods
//
//  Created by Matan Cohen on 9/4/16.
//
//

import Foundation
import UIKit

@objc open class CrossfadeUpwardTransitionObject: NSObject, TransitionObject {
    internal var viewToAnimateTo :UIView
    internal var frameToAnimateTo : CGRect?
    internal var duration : TimeInterval
    
    public init(viewToAnimateTo: UIView , frameToAnimateTo : CGRect?, duration : TimeInterval) {
        self.viewToAnimateTo = viewToAnimateTo
        self.frameToAnimateTo = frameToAnimateTo
        self.duration = duration
    }
    
    public init(viewToAnimateTo: UIView , duration : TimeInterval) {
        self.viewToAnimateTo = viewToAnimateTo
        self.duration = duration
    }
}
