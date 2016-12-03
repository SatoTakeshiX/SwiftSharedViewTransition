//
//  TransitionNavigationController.swift
//  SharedTransition
//
//  Created by satoutakeshi on 2016/12/03.
//  Copyright © 2016年 Personal Factory. All rights reserved.
//

import UIKit

class TransitionNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self 

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = Transition()
        switch operation {
        case .push:
             transition.forward = true
            return transition
        case .pop:
            transition.forward = false
            return transition
        default:
            return nil
        
        }
        

    }

}
