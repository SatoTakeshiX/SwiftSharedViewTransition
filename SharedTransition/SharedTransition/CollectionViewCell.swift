//
//  CollectionViewCell.swift
//  SharedTransition
//
//  Created by satoutakeshi on 2016/12/03.
//  Copyright © 2016年 Personal Factory. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    
    class func cellOfSize() -> CGSize {
        let width = (UIScreen.main.bounds.width - 10) / 4
        return CGSize(width: width, height: width)
    }
    
}
