//
//  QuestionnaireResults.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/15/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
import SwiftyJSON

class QuestionnaireResults: NSObject {
    var message : String?
    var score   : String?
    
    
    init?(json: JSON){
        message    = json["message"].string
        score      = json["score"].string
    }
    
}
