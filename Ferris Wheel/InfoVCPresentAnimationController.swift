//
//  InfoVCPresentAnimationController.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/12/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

class InfoVCPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame :CGRect!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        let snapshot = toVC.view.snapshotViewAfterScreenUpdates(true)
        let snapshotContainerView = UIView(frame: originFrame)
        snapshotContainerView.clipsToBounds = true
        
        toVC.view.hidden = true
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotContainerView)
        snapshotContainerView.addSubview(snapshot)
        
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: {
            
            snapshotContainerView.frame = finalFrame
            
            }) { _ in
                toVC.view.hidden = false
                snapshotContainerView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}