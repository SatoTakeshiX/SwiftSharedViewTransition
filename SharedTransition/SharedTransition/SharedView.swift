//
//  Protocol.swift
//  SharedTransition
//
//  Created by satoutakeshi on 2016/12/03.
//  Copyright © 2016年 Personal Factory. All rights reserved.
//

import Foundation
import UIKit
protocol SharedView {
    func createImageView() -> UIImageView?
    var sharedView:UIView? { get }
}
