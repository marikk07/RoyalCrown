//
//  ServiceModel.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/16/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ServiceModel: NSObject {

    var uid : NSInteger?
    var title : String?
    var website : String?
    var type : String?
    var descript : String?
    
    init?(json: JSON){
        uid       = json["id"].int
        title     = json["title"].string
        website   = json["website"].string
        type      = json["type"].string
        descript  = json["description"].string
    }
    
}
