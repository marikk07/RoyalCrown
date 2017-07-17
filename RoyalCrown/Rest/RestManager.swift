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
    
    
    func reportAccident(name : String, policyNamber : String, phoneNamber : String, photos : Array<Any>, completionHandler: @escaping CompletionHandler)  {
        
        let params = ["name"              :name,
                      "reg_policy_number" :policyNamber,
                      "phone_number"      :phoneNamber,
                      "photos_attributes" :photos] as [String : Any]
        
        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.accidentReports, method: .post, parameters: params).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]

                
                completionHandler(swiftyJsonVar, nil)
                
            }
        }
    }
    
    
    func getAboutRoyalAssist(completionHandler: @escaping CompletionHandler) {
        
        
        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.aboutRoyalAssist, method: .get).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]
                
                let message = swiftyJsonVar.first?["about_royal_assist"].string
                
                completionHandler(message, nil)
                
            }
        }
    }
    
    func getServices(type : String, completionHandler: @escaping CompletionHandler) {
        let params = ["service_type":type]
        
        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.services, method: .get, parameters: params).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]
                
                var servicesArray : [Any] = []
                
                for service in (swiftyJsonVar.first?.array)! {
                    let branchModel = ServiceModel.init(json: service)
                    servicesArray.append(branchModel!)
                }
                completionHandler(servicesArray, nil)
                
            }
        }
    }
    
    func getAccidentInstructions(completionHandler: @escaping CompletionHandler)  {
        
        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.accidentInstructions, method: .get).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]
                
                var accidentArray : [Any] = []
                
                for service in (swiftyJsonVar.first?.array)! {
                    let accident = AccidentInstructionsModel.init(json: service)
                    accidentArray.append(accident!)
                }
                completionHandler(accidentArray, nil)
                
            }
        }
        
    }
    
    func aboutUs(completionHandler: @escaping CompletionHandler)  {
        Alamofire.request(RestBaseConstants.basePath + RestRequstsConstants.aboutUs, method: .get).responseJSON {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar : [JSON] = [JSON(responseData.result.value!)]
                
                let message = swiftyJsonVar.first?["about_us"].string
                
                completionHandler(message, nil)
                
            }
        }
    }

    
}
