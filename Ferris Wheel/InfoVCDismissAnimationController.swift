//
//  InfoVCDismissAnimationController.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/12/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

class InfoVCDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var destinationFrame: CGRect!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        print("destinationFrame:\(destinationFrame)")
        let containerView = transitionContext.containerView()!
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let snapshot = fromVC.view.snapshotViewAfterScreenUpdates(false)
        let snapshotContainerView = UIView(frame: fromVC.view.frame)
        snapshotContainerView.clipsToBounds = true

        print("snapshotContainerView:\(snapshotContainerView)")
        snapshotContainerView.addSubview(snapshot)
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotContainerView)
        fromVC.view.hidden = true

        weak var wSelf = self
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: {
            snapshotContainerView.frame = wSelf!.destinationFrame
        }) { _ in
            snapshotContainerView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}