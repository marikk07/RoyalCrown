//
//  PhotoCell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/8/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var backImage: UIImageView!
    var wasSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedView.isHidden = !wasSelected

    }
    
    public func setUpWithImage( image:UIImage){
        self.backImage.image = image
    }
    public func selectCell(){
        self.selectedView.isHidden = !self.selectedView.isHidden
    }
    
    override func prepareForReuse() {
        self.backImage.image = nil
        self.selectedView.isHidden = true
    }

}
