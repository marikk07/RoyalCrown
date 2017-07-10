//
//  RestConstatns.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/9/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import Foundation

struct RestBaseConstants {
    static let adress           = "31.131.21.105:82/api/v1/"
    static let basePath         = "http://\(RestBaseConstants.adress)"
    static let baseUrl: URL     = URL(string: "\(RestBaseConstants.basePath)")!

}

struct RestRequstsConstants {
    static let branches                 = "branches"
    static let accidentInstructions     = "accident_instructions"
    static let baseUrl                  = "services"
    static let aboutUs                  = "about_us"
    static let aboutRoyalAssist         = "about_royal_assist"
    static let accidentReports          = "accident_reports"
    static let questionnaires           = "questionnaires"
    static let questions                = "questions"
    static let questionnaireResults     = "questionnaire_results"
    static let contacts                 = "contacts"
}



// MARK: MessageType

enum NetworkError: Error {
    case success
    case wrong
    case imageToSmall
    case badInput
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .success:
            return NSLocalizedString("Success", comment: "")
        case .wrong, .badInput:
            return NSLocalizedString("Something went wrong", comment: "")
        case .imageToSmall:
            return NSLocalizedString("Image to small", comment: "")
        }
    }
    
}
