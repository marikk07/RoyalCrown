//
//  QuestionnaireModel.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/13/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import Foundation
import SwiftyJSON




class QuestionnaireModel: NSObject {
    var uid : String?
    var title : String?
    var modelDescription : String?
    var created_at : String?
 
    
    init?(json: JSON){
        uid                 = json["uid"].string
        title               = json["title"].string
        modelDescription    = json["description"].string
        created_at          = json["created_at"].string
    }
}
