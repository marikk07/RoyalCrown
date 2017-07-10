//
//  RestManager.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/9/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CompletionHandler = (_ data: Any?, _ error: NSError?) -> Void

// MARK: RestManager
class RestManager {
    private let sessionManager = SessionManager()
    
    
    func branches(completionHandler: @escaping CompletionHandler) {

        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.branches).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]
                print(swiftyJsonVar)
                
                let branchArray : NSMutableArray = []
                
                for branchJS in (swiftyJsonVar.first?.array)! {
                    let branchModel = BranchModel.init(json: branchJS)
                    branchArray.add(branchModel!)       
                }
                completionHandler(branchArray, nil)
                
            }
        }
    }
    
    
    
    
}
