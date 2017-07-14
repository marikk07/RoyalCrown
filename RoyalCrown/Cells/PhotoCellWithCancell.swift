//
//  PhotoCellWithCancell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/9/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class PhotoCellWithCancell: UICollectionViewCell {

    @IBOutlet weak private var backgroundImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setUpWithImage( image:UIImage){
        backgroundImg.image = image
    }

}
