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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        let snapshotContainerView = UIView(frame: originFrame)
        snapshotContainerView.clipsToBounds = true
        
        toVC.view.isHidden = true
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotContainerView)
        snapshotContainerView.addSubview(snapshot!)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            
            snapshotContainerView.frame = finalFrame
            
            }) { _ in
                toVC.view.isHidden = false
                snapshotContainerView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
