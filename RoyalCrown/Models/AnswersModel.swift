//
//  AnswersModel.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/14/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
import SwiftyJSON
class AnswersModel: NSObject {
    
    var uid : NSInteger?
    var text : String?
    var correct : Bool?
    var order : NSInteger?
    
    init?(json: JSON){
        uid        = json["id"].int
        text       = json["text"].string
        correct    = json["correct"].bool
        order      = json["order"].int
    }
    
}
