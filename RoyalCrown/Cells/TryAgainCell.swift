//
//  TryAgainCell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/16/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

protocol TryAgainDelegate {
    func tryAgain()
}


class TryAgainCell: UICollectionViewCell {

    @IBOutlet weak var tryAgainbutton: UIButton!
    var delegate: TryAgainDelegate?
    

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        tryAgainbutton?.layer.masksToBounds = true
        tryAgainbutton?.layer.cornerRadius = (tryAgainbutton?.frame.size.height)!/2
    }
    
    //MARK: - Actions
    
    @IBAction func tryAgainActions(_ sender: Any) {
        self.delegate?.tryAgain()
    }
    
}
