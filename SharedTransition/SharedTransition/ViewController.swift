//
//  ViewController.swift
//  SharedTransition
//
//  Created by satoutakeshi on 2016/12/01.
//  Copyright © 2016年 Personal Factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedIndexPath: IndexPath? = nil
    var selectedImageView : UIImageView?
    var photos : [UIImage] = {
        return (1...8).map {
            UIImage.init(named: "nature" + String($0))!
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.image = photos[indexPath.row]
        self.selectedImageView = cell.imageView
        
        return cell
    }
    
    
}

extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        self.selectedImageView = cell.imageView
        
        if let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.image = self.selectedImageView?.image
            self.selectedIndexPath = indexPath
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CollectionViewCell.cellOfSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
}


extension ViewController : SharedView {
    //MARK: for Transition
    func createImageView() -> UIImageView? {
        guard let selectedImageView = self.selectedImageView else {
            return nil
        }
        
        let imageView = UIImageView(image: selectedImageView.image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = selectedImageView.convert(selectedImageView.frame, to: self.view)
        return imageView
    }
}

