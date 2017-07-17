//
//  TestProgressCell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/13/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class TestProgressCell: UICollectionViewCell {
    @IBOutlet weak var heightConstreight: NSLayoutConstraint!
    @IBOutlet weak var isActiveHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bacView: UIView!
    var isActive : Bool?
    var wasActive : Bool?
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if isActive == true {
            bacView.backgroundColor = ColorsConst.violet
            heightConstreight.priority = 750;
            heightConstreight.isActive = false
            isActiveHeight.priority = 999
            isActiveHeight.isActive = true
        }else if wasActive == true {
            bacView.backgroundColor = ColorsConst.lightViolet
            heightConstreight.priority = 750
            heightConstreight.isActive = true
            isActiveHeight.priority = 999
            isActiveHeight.isActive = false
        }
        else {
            bacView.backgroundColor = ColorsConst.backGray
            heightConstreight.priority = 750
            heightConstreight.isActive = true
            isActiveHeight.priority = 999
            isActiveHeight.isActive = false
        }


        layoutIfNeeded()
        bacView.layer.borderColor = UIColor.lightGray.cgColor
        bacView.layer.borderWidth = 1.0
        bacView.layer.masksToBounds = true
        bacView.layer.cornerRadius = bacView.frame.size.height/2
        
    }
}
