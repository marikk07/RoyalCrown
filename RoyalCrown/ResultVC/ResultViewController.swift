//
//  ResultViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/14/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet private weak var reviewButton: UIButton!
    @IBOutlet private weak var tryAgainButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    var questionList : [TestModel]?
    var questionnaire_id : NSInteger?
    var params : [String:Any] = [:]
    var result : QuestionnaireResults?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var anwersArray = Array<Any>()
        for test in questionList! {
            let dict = ["question_id"   :test.uid,
                        "answer_id"     :test.selectedAnswer?.uid]
            anwersArray.append(dict)
        }
        params["questionnaire_id"] = questionnaire_id
        params["questionnaire_answers_attributes"] = anwersArray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        RestManager().getQuestionResult(params: params) { (result, error) in
            if error == nil{
                self.result = result as! QuestionnaireResults?
                self.setUi()
            }
        }

    }
    
    func setUi()  {
        self.reviewButton.layer.cornerRadius = self.reviewButton.frame.height/2
        self.tryAgainButton.layer.cornerRadius = self.tryAgainButton.frame.height/2
        self.tryAgainButton.layer.borderWidth = 1.0
        self.tryAgainButton.layer.borderColor = ColorsConst.violet.cgColor
        var parseMessage = self.result?.message
        parseMessage = parseMessage?.replacingOccurrences(of: "<p>", with: "")
        parseMessage = parseMessage?.replacingOccurrences(of: "</p>", with: "")
        
            
        self.resultLabel.text = "Your results:"+(self.result?.score)!
        self.messageLabel.text = parseMessage
    }
    
    //
    @IBAction func reviewAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.reviewAnswersViewController) as! ReviewAnswersViewController
        vc.questionList = questionList
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func tryAgainAction(_ sender: Any) {
        for vc in (self.navigationController?.viewControllers)! {
            if vc.isKind(of: QuestionTestViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        for vc in (self.navigationController?.viewControllers)! {
            if vc.isKind(of: QuizViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    
}
