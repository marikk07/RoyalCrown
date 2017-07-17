//
//  AnswerCell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/13/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AnswerCell: UICollectionViewCell {
    @IBOutlet weak var answerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupWithAnswer(answer : AnswersModel) {
        answerLabel.text = answer.text
    }
    func setSelected() {
        answerLabel.textColor = UIColor.black
        dropShadow()
    }
    
    func dropShadow(scale: Bool = true) {
        
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    
    override func prepareForReuse() {
        answerLabel.textColor = UIColor.darkGray
        self.layer.shadowPath = nil
        self.layer.shadowColor = UIColor.clear.cgColor
        
    }

}
