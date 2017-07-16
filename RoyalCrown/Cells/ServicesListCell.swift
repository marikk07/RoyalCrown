//
//  ServicesListCell.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/16/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class ServicesListCell: UITableViewCell {

    @IBOutlet private weak var mainLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupWith(service : ServiceModel)  {
        mainLabel.text = service.title
    }
    
    func setupWith(accident : AccidentInstructionsModel)  {
        mainLabel.text = accident.title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
