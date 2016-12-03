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
        
        let containerView = transitionContext.containerView
        
        //遷移先のviewをaddSubViewする(fromVC.viewは最初からcontainerViewがsubviewとして持っている
        containerView.addSubview(toVC.view)
        
        //addSubViewでレイアウトが崩れるため再レイアウトする
        toVC.view.layoutIfNeeded()
        
        //アニメーション用のimageViewを新しく作成する
        guard let sourceImageView = (fromVC as? SharedView)?.createImageView() else {
            return
        }
        
        guard let destinationImageView = (toVC as? SharedView)?.createImageView() else {
            return
        }
        
        //遷移先のimageViewをaddSubviewする
        containerView.addSubview(sourceImageView)
        
        toVC.view.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.05,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        
                        let destinationImageFrame = destinationImageView.frame
                        //アニメーション開始
                        // 遷移もとのimageViewのframeとconteModeを遷移先のimageViewに代入
                        sourceImageView.frame = CGRect.init(x: destinationImageFrame.origin.x, y: destinationImageFrame.origin.y + 64, width: destinationImageFrame.width, height: destinationImageFrame.height)//destinationImageView.frame
                        sourceImageView.contentMode = destinationImageView.contentMode
                        
                        // cellのimageViewを非表示にする
                        (fromVC as? SharedView)?.createImageView()?.isHidden = true
                        
                        toVC.view.alpha = 1.0
                        
        }, completion: {
            finished in

            
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
        
        //最初からcontainerViewがsubviewとして持っているfromVC.viewを削除
        fromeVC.view.removeFromSuperview()
        
        // toView -> fromViewの順にaddSubView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromeVC.view)
        
        guard let sourceImageView = (fromeVC as? SharedView)?.createImageView() else {
            return
        }
        
        guard let destinationImageView = (toVC as? SharedView)?.createImageView() else {
            return
        }
        
        //戻るときに一度ViewControllerのcellのimageViewを非表示にする
        guard let viewController = toVC as? ViewController, let cell = viewController.collectionView.cellForItem(at: viewController.selectedIndexPath!) as? CollectionViewCell  else {
            return
        }
        
        cell.imageView.isHidden = true
        
        
        containerView.addSubview(sourceImageView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.05, options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        let destinationImageFrame = destinationImageView.frame
                        sourceImageView.frame = CGRect.init(x: destinationImageFrame.origin.x, y: destinationImageFrame.origin.y + 64, width: destinationImageFrame.width, height: destinationImageFrame.height)
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
