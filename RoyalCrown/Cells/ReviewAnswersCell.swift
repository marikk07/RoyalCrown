//
//  ReviewAnswersCell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/15/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class ReviewAnswersCell: UICollectionViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupWithTest(test:TestModel, number: NSInteger) {
        numberLabel.text = String(number) + "/10"
        questionLabel.text = test.text
        let rightAnswer = test.answers.filter({ $0.correct == true })
        if test.selectedAnswer != rightAnswer.first {
            answerLabel.textColor = UIColor.red
        }
        answerLabel.text = test.selectedAnswer?.text
     }

}
