//
//  AccidentInstructionsModel.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/16/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
import SwiftyJSON

class AccidentInstructionsModel: NSObject {

    
    var uid : NSInteger?
    var title : String?
    var tabs : Bool?
    var tab_1_title : String?
    var tab_1_content : String?
    var tab_2_title : String?
    var tab_2_content : String?
    
    init?(json: JSON){
        uid             = json["id"].int
        title           = json["title"].string
        tabs            = json["tabs"].bool
        tab_1_title     = json["tab_1_title"].string
        tab_1_content   = json["tab_1_content"].string
        tab_2_title     = json["tab_2_title"].string
        tab_2_content   = json["tab_2_content"].string
    }
    
}
