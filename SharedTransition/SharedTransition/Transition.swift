//
//  Transition.swift
//  SharedTransition
//
//  Created by satoutakeshi on 2016/12/03.
//  Copyright © 2016年 Personal Factory. All rights reserved.
//

import UIKit

class Transition: NSObject, UIViewControllerAnimatedTransitioning {

    // pushなら　forward == true 
    var forward = false
    
    //アニメーションの時間
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    //アニメーションの定義
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.forward {
            //push時のアニメーション
            forwardTransition(transitionContext)
        } else {
            backwardTransition(transitionContext)
        }
    }
    
}

extension Transition {
    //push時のアニメーション
    fileprivate func forwardTransition (_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        

        let fromView = (fromVC as? SharedView)?.sharedView
        let toView = (toVC as? SharedView)?.sharedView
        
        
        
        let containerView = transitionContext.containerView
        
        //遷移先のviewをaddSubViewする(fromVC.viewは最初からcontainerViewがsubviewとして持っている
        containerView.addSubview(toVC.view)

        
        //アニメーション用のimageViewを新しく作成する
        guard let sourceImageView = (fromVC as? SharedView)?.createImageView() else {
            return
        }
        
        guard let destinationImageView = (toVC as? SharedView)?.createImageView() else {
            return
        }
        // Take Snapshot of fomView
        let snapshotView = fromView?.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = containerView.convert((fromView?.frame)!, to: fromView?.superview)
        fromView?.isHidden = true
        
        // Setup the initial view states
        //toVCの最終的なframeをfinalFrameForViewControllerで取得してframeにセットする
        toVC.view.frame = transitionContext.finalFrame(for: toVC)

        toVC.view.alpha = 0
        toView?.isHidden = true
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView!)
        
        toVC.view.layoutIfNeeded()
        containerView.layoutIfNeeded()
//        //遷移先のimageViewをaddSubviewする
//        containerView.addSubview(sourceImageView)
//        toVC.view.alpha = 0.0
//        
//        //addSubViewでレイアウトが崩れるため再レイアウトする
//        toVC.view.layoutIfNeeded()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.05,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        
//                       // let destinationImageFrame = destinationImageView.frame
//                        //アニメーション開始
//                        // 遷移もとのimageViewのframeとconteModeを遷移先のimageViewに代入
//                        sourceImageView.frame = destinationImageView.frame
//                        sourceImageView.contentMode = destinationImageView.contentMode
//                        
//                        // cellのimageViewを非表示にする
//                        (fromVC as? SharedView)?.createImageView()?.isHidden = true
//                        
//                        toVC.view.alpha = 1.0
                      
                        toVC.view.alpha = 1.0
                        // Move the SnapshotView
                        snapshotView?.frame = (toView?.frame)!//containerView.convert((toView?.frame)!, from: toView?.superview)
                      
                        
                        
        }, completion: {
            finished in
            
            toView?.isHidden = false ;
            fromView?.isHidden = false;
           // snapshotView?.removeFromSuperview()
            
            //アニメーション終了
            transitionContext.completeTransition(true)
        })
    }
    
    //pop時のアニメーション
    fileprivate func backwardTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        // Pushと逆のアニメーション
        guard let fromeVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        //前回遷移したさいのImageViewが残っているので一度全てを外す
        containerView.subviews.forEach {
            view in
            view.removeFromSuperview()
        }
        
        // toView -> fromViewの順にaddSubView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromeVC.view)

        guard let sourceImageView = (fromeVC as? DetailViewController)?.createImageView() else {
            return
        }
        
        guard let destinationImageView = (toVC as? ViewController)?.createImageView() else {
            return
        }
        
        //戻るときに一度ViewControllerのcellのimageViewを非表示にする
        guard let viewController = toVC as? ViewController, let cell = viewController.collectionView.cellForItem(at: viewController.selectedIndexPath!) as? CollectionViewCell  else {
            return
        }
        
        cell.imageView.isHidden = true
        
        containerView.addSubview(sourceImageView)
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.05, options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        sourceImageView.frame = destinationImageView.frame
                        
                        fromeVC.view.alpha = 0.0
                        
        }, completion: {
            finished in
            sourceImageView.isHidden = true
            
            (toVC as? ViewController)?.selectedImageView?.isHidden = false
            cell.imageView.isHidden = false
            sourceImageView.removeFromSuperview()
            fromeVC.view.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}
