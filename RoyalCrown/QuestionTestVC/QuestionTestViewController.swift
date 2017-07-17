//
//  QuestionTestViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/13/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class QuestionTestViewController: UIViewController {
    
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var namberLabel: UILabel!
    @IBOutlet private weak var questionLabel: UILabel!
    fileprivate  weak var progressView : TestProgressView? = nil
    @IBOutlet fileprivate weak var testCollection: UICollectionView!
    fileprivate var questionList : [TestModel]?
    fileprivate var selectedIndexPath : IndexPath?
    var questionnaire_id : NSInteger?
    var test : TestModel?
    var testNumber : NSInteger = 0
    var tittleStr : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        progressView = TestProgressView.fromNib()
        progressView?.delegate = self
        progressView?.testNumber = testNumber
        let nibName = UINib(nibName: CollectionViewCellIdentifiers.answerCell, bundle:nil)
        testCollection.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.answerCell)
        
        
        if testNumber == 0 {
            RestManager().getQuestionsListWithID(questId: questionnaire_id!) { (questionArray, error) in
                self.questionList = questionArray as! [TestModel]?
                self.setupWithQuestion(question: (self.questionList?[self.testNumber])!)
                self.test = self.questionList?[self.testNumber]
                self.testCollection.reloadData()
                
            }
        }else{
            self.setupWithQuestion(question: (self.questionList?[self.testNumber])!)
            self.test = self.questionList?[self.testNumber]
            self.testCollection.reloadData()
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(progressView!)
        setConstraightsTo(progressView: progressView!)
        self.testCollection.reloadData()
        topLabel.text = tittleStr
        
    }
    
    // MARK: Actions
    
    
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
    
    
    // MARK: Public methods
    
    func setupWithQuestion(question : TestModel) {
        namberLabel.text = String(testNumber + 1) + "/" + String ((questionList?.count)!)
        questionLabel.text = question.text
        
        
    }
    
    
    
    // MARK: Private methods
    func setConstraightsTo(progressView: TestProgressView) {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: progressView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: progressView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.0, constant: CGFloat(40.0)).isActive = true
        
    }
}






extension QuestionTestViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, TestProgressViewDelegate {
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if test?.answers.count != nil{
            return test!.answers.count
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnswerCell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCellIdentifiers.answerCell, for: indexPath) as! AnswerCell
        cell.setupWithAnswer(answer: (test?.answers[indexPath.row])!)
        if (test?.answers[indexPath.row])! == questionList?[testNumber].selectedAnswer  {
            cell.setSelected()
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let constraintRect = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.height)
        let data = (questionList?[indexPath.row].text)!
        
        let boundingBox = data.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
        
        let cellHeight:CGFloat = boundingBox.height + 30
        let cellWidth:CGFloat = collectionView.frame.width
        
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        questionList?[testNumber].selectedAnswer = questionList?[testNumber].answers[indexPath.row]
        goNext()
        
    }
    
    
    //MARK : - TestProgressViewDelegate
    
    func previous() {
        if testNumber != 0{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func next() {
        if questionList?[testNumber].selectedAnswer != nil{
            goNext()
        }else{
            AlertHelper.showAlert(title: "You need to select the answer", message: "")
        }
        
    }
    
    
    // MARK : --
    
    func goNext() {
        if testNumber < ((questionList?.count)! - 1){
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.questionTestViewController) as! QuestionTestViewController
            vc.testNumber = testNumber+1
            vc.questionnaire_id = self.questionnaire_id
            vc.questionList = self.questionList
            vc.tittleStr = self.tittleStr
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
            
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.resultViewController) as! ResultViewController
            vc.questionList = questionList
            vc.questionnaire_id = questionnaire_id
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}


