//
//  MainCell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/8/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    @IBOutlet private weak var cellLabel: UILabel!
    @IBOutlet private weak var backgroundImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func fillCellWithImageAndTitle(image: UIImage, title:String) {
        self.backgroundImg.image = image
        self.cellLabel.text = title
    }
    
    
}
