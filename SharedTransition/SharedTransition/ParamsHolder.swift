//
//  ParamsHolder.swift
//  SharedTransition
//
//  Created by satoutakeshi on 2016/12/01.
//  Copyright © 2016年 Personal Factory. All rights reserved.
//

import UIKit

struct ParamsHolder {

  var nav :UINavigationController
  var fromVC: SharedViewTransitionDataSource
  var toVC: SharedViewTransitionDataSource
  var duration: Double
  
  init(nav:UINavigationController, fromVC:SharedViewTransitionDataSource, toVC:SharedViewTransitionDataSource, duration:Double){
    self.nav = nav
    self.fromVC = fromVC
    self.toVC = toVC
    self.duration = duration
  }
  
}
