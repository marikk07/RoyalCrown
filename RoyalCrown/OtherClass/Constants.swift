//
//  File.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/3/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import Foundation
import UIKit
let extraPhoneNumber = "77777773"
let cancelCall = "Cancel"
let makeCall = "Make a call"


struct TableViewCellIdentifiers {
    static let royalAssistCell = "RoyalAssist"
    static let servicesListCell = "ServicesListCell"
}

struct CollectionViewCellIdentifiers {
    static let mainCell = "MainCell"
    static let photoCell = "PhotoCell"
    static let photoCellWithCancell = "PhotoCellWithCancell"
    static let quizCell = "QuizCell"
    static let testProgressCell = "TestProgressCell"
    static let answerCell = "AnswerCell"
    static let reviewAnswersCell = "ReviewAnswersCell"
    static let tryAgainCell = "TryAgainCell"
    
}

struct ViewControllersIdentifiers {
    static let royalAssistViewController = "RoyalAssistViewController"
    static let aboutRoyalViewController = "AboutRoyalAssistViewController"
    static let accidentReportViewController = "AccidentReportViewController"
    static let aboutViewController = "AboutViewController"
    static let mapViewController = "GoogleMapViewController"
    static let cameraViewController = "CameraViewController"
    static let quizViewController = "QuizViewController"
    static let questionTestViewController = "QuestionTestViewController"
    static let resultViewController = "ResultViewController"
    static let reviewAnswersViewController = "ReviewAnswersViewController"
    static let servicesViewController = "ServicesViewController"
    static let servicesListViewController = "ServicesListViewController"
    static let serviceDescriptViewController = "ServiceDescriptViewController"
    static let accidentListViewController = "AccidentListViewController"
    static let accidentDesctiptViewController = "AccidentDesctiptViewController"
    static let aboutUsViewController = "AboutUsViewController"
}

struct ConstraightConst {
    static let mapBottomOpenConst = 170
    static let mapBottomCloseConst = 60
}

struct ColorsConst {
    static let violet = #colorLiteral(red: 0.1882352941, green: 0.168627451, blue: 0.5019607843, alpha: 1)
    static let lightViolet = #colorLiteral(red: 0.5921568627, green: 0.5843137255, blue: 0.7490196078, alpha: 1)
    static let backGray = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
}

struct Service {
    static let business = "business"
    static let personal = "personal"
}
