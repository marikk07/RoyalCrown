//
//  QuizCell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/13/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class QuizCell: UICollectionViewCell {

    @IBOutlet private weak var tittleLabel: UILabel!
    @IBOutlet private weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setupWith(tittle : String, mainText : String) {
        tittleLabel.text = tittle
        mainLabel.text = mainText
    }
    func setupWith(questModel: QuestionnaireModel) {
        tittleLabel.text = questModel.title
        mainLabel.text = questModel.modelDescription
    }
    
}
