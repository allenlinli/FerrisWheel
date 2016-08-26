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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
        let snapshotContainerView = UIView(frame: fromVC.view.frame)
        snapshotContainerView.clipsToBounds = true

        snapshotContainerView.addSubview(snapshot!)
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotContainerView)
        fromVC.view.isHidden = true

        weak var wSelf = self
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            snapshotContainerView.frame = wSelf!.destinationFrame
        }) { _ in
            snapshotContainerView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
