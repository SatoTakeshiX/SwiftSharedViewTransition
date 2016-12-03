//
//  SharedViewTransition.swift
//  SharedTransition
//
//  Created by satoutakeshi on 2016/12/01.
//  Copyright © 2016年 Personal Factory. All rights reserved.
//

import UIKit



class SharedViewTransition: NSObject {
    
    var fromVC: UIViewController? = nil
    var toVC: UIViewController? = nil
    var arrParamHolders:[ParamsHolder]? = nil
    
    
    class func addTransitionWithFromViewControllerClass(fromVC:SharedViewTransitionDataSource,
                                                        toVC:SharedViewTransitionDataSource,
                                                        navgationController:UINavigationController,
                                                        duration:Double){
        
        /*
         BOOL found = false;
         for (ParamsHolder *holder in [[ASFSharedViewTransition shared] arrParamHolders]) {
         if (holder.fromVCClass == aFromVCClass && holder.toVCClass == aToVCClass) {
         holder.duration = aDuration;
         holder.nav = aNav;
         holder.nav.delegate = [ASFSharedViewTransition shared];
         
         found = true;
         break;
         }
         }
         
         if (!found) {
         ParamsHolder *holder = [[ParamsHolder alloc] init];
         holder.fromVCClass = aFromVCClass;
         holder.toVCClass = aToVCClass;
         holder.duration = aDuration;
         holder.nav = aNav;
         
         holder.nav.delegate = [ASFSharedViewTransition shared];
         [[[ASFSharedViewTransition shared] arrParamHolders] addObject:holder];
         }
         */
//        var found = false
//        if let attParamHolders = SharedViewTransition.shared.arrParamHolders {
//            for holder in attParamHolders {
////                if holder.fromVC == fromVC && holder.toVC == toVC {
////
////                }
//                
//                
//            }
//        }
    
    }
    
    
    static let shared = SharedViewTransition()
    private override init() {
    }
}

extension SharedViewTransition {
    /*
     #pragma mark - Private Methods
     
     - (ParamsHolder *)paramHolderForFromVC:(UIViewController *)fromVC ToVC:(UIViewController *)toVC reversed:(BOOL *)reversed {
     ParamsHolder *pHolder = nil;
     for (ParamsHolder *holder in [[ASFSharedViewTransition shared] arrParamHolders]) {
     if (holder.fromVCClass == [fromVC class] && holder.toVCClass == [toVC class]) {
     pHolder = holder;
     }
     else if (holder.fromVCClass == [toVC class] && holder.toVCClass == [fromVC class]) {
     pHolder = holder;
     
     if (reversed) {
     *reversed = true;
     }
     }
     }
     
     return pHolder;
     }
     */
    
    //MARK: Private Mathods 
//    func paramHolder(fromVC:UIViewController, toVC:UIViewController, reversed: Bool) -> ParamsHolder? {
//        var pHolder :ParamsHolder? = nil
//        if let paramHolders = SharedViewTransition.shared.arrParamHolders {
//            for holder in paramHolders {
//                if holder.toVC == fromVC && holder.toVC == toVC {
//                    pHolder = holder
//                } else if(holder.fromVC == toVC && holder.toVC == fromVC) {
//                    pHolder = holder
//                    if reversed {
//                       
//                    }
//                }
//            }
//            return pHolder
//        }
//        
//    }
}
