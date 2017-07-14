//
//  BranchModel.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/9/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol JSONMappable {
    init?(json: JSON)
}
class BranchModel: NSObject {

    var uid : String?
    var title : String?
    var address : String?
    var phone : String?
    var email : String?
    var fax : String?
    var postal_code : String?
    var latitude : Double?
    var longitude : Double?
    
    init?(json: JSON){
        uid             = json["uid"].string
        title           = json["title"].string
        address         = json["address"].string
        phone           = json["phone"].string
        postal_code     = json["postal_code"].string
        latitude        = json["latitude"].double
        longitude       = json["longitude"].double
        fax             = json["fax"].string
        email           = json["email"].string

    }
    
//    init(withJson:Dictionary<AnyHashable, Any>) {
//        self.uid        = withJson["id"] as! String?
//        self.title      = withJson["title"] as! String?
//        self.address    = withJson["address"] as! String?
//        self.phone      = withJson["phone"] as! String?
//        self.postal_code = withJson["postal_code"] as! String?
//        self.latitude   = withJson["latitude"] as! Double?
//        self.longitude  = withJson["longitude"] as! Double?
//    }
    
    //        Alamofire.request( URL(string:url)!).responseJSON { (responseData) -> Void in
    //            if((responseData.result.value) != nil) {
    //                let swiftyJsonVar = JSON(responseData.result.value!)
    //                print(swiftyJsonVar)
    //              let branchArray  = swiftyJsonVar.array?.map { return BranchModel.init(withJson: $0.object as! Dictionary<AnyHashable, Any>)}
    //                print(branchArray as Any)
    //               // completion(Result.success(branchArray))
    //            }
    //        }
    
}
