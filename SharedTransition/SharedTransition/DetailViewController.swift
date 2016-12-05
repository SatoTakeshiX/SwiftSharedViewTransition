//
//  DetailViewController.swift
//  SharedTransition
//
//  Created by satoutakeshi on 2016/12/03.
//  Copyright © 2016年 Personal Factory. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red
    }
    override func viewDidAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension DetailViewController : SharedView {
    //MARK: for Transition
    func createImageView() -> UIImageView? {
        guard let detailImageView = self.imageView else {
            return nil
        }
        
        let imageView = UIImageView(image: self.image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = detailImageView.convert(detailImageView.frame, to: self.view)
        return imageView
    }
    
    var sharedView: UIView? {
        get {
            return self.imageView
        }
    }
}

