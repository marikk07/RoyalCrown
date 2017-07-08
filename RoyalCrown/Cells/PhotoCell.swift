//
//  PhotoCell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/8/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var backImage: UIImageView!
    
    public func setUpWithImage( image:UIImage){
        self.backImage.image = image
    }

}
