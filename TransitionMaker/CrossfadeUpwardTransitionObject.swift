//
//  CrossfadeUpwardTransitionObject.swift
//  Pods
//
//  Created by Matan Cohen on 9/4/16.
//
//

import Foundation
import UIKit

public class CrossfadeUpwardTransitionObject: NSObject, TransitionObject {
    internal var viewToAnimateTo :UIView
    internal var frameToAnimateTo : CGRect?
    internal var duration : NSTimeInterval
    
    public init(viewToAnimateTo: UIView , frameToAnimateTo : CGRect?, duration : NSTimeInterval) {
        self.viewToAnimateTo = viewToAnimateTo
        self.frameToAnimateTo = frameToAnimateTo
        self.duration = duration
    }
}