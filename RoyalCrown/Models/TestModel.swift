//
//  TestModel.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/14/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
import SwiftyJSON

class TestModel: NSObject {

    var uid : NSInteger?
    var text : String?
    var order : NSInteger?
    var answers : [AnswersModel] = []
    var selectedAnswer : AnswersModel?
    
    init?(json: JSON){
        uid        = json["id"].int
        text       = json["text"].string
        order      = json["order"].int
        for jsonElement in json["answers"].array! {
            answers.append(AnswersModel.init(json: jsonElement)!)
        }
    }
    
    
    
}
