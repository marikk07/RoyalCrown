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
import CoreLocation

typealias CompletionHandler = (_ data: Any?, _ error: NSError?) -> Void

// MARK: RestManager
class RestManager {
    private let sessionManager = SessionManager()
    
    
    func branches(completionHandler: @escaping CompletionHandler) {
        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.branches).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]
                print(swiftyJsonVar)
                var branchArray : [Any] = []
                for branchJS in (swiftyJsonVar.first?.array)! {
                    let branchModel = BranchModel.init(json: branchJS)
                    branchArray.append(branchModel!)
                }
                completionHandler(branchArray, nil)
            }
        }
    }
    
    func drawMapsPath(startLocation: CLLocation, endLocation: CLLocation, completionHandler: @escaping CompletionHandler)  {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        let url = MapsPath.baseUrl + origin + "&destination=" + destination + "&mode=driving"
        Alamofire.request(url).responseJSON { response in
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            completionHandler(routes, nil)
        }
    }
    
    func getQuestionnaires(completionHandler: @escaping CompletionHandler) {
        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.questionnaires).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]
                print(swiftyJsonVar)
                var branchArray : [Any] = []
                for branchJS in (swiftyJsonVar.first?.array)! {
                    let branchModel = QuestionnaireModel.init(json: branchJS)
                    branchArray.append(branchModel!)
                }
                completionHandler(branchArray, nil)

            }
        }
    }
    
    
    func getQuestionsListWithID(questId : NSInteger, completionHandler: @escaping CompletionHandler) {
        let params = ["questionnaire_id":questId]

  
        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.questions, method: .get, parameters: params).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]
                print(swiftyJsonVar)
                var branchArray : [Any] = []

                for branchJS in (swiftyJsonVar.first?.array)! {
                    let branchModel = TestModel.init(json: branchJS)
                    branchArray.append(branchModel!)
                }
                
                completionHandler(branchArray, nil)
                
            }
        }

    }

    func getQuestionResult(params : Dictionary<String, Any>, completionHandler: @escaping CompletionHandler) {
        let params = params
        
        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.questionnaireResults, method: .post, parameters: params).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]
                let result = QuestionnaireResults.init(json: swiftyJsonVar.first!)

                completionHandler(result, nil)
                
            }
        }
        
    }
    
    

    
}
