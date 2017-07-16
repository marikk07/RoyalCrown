//
//  ReviewAnswersViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/15/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class ReviewAnswersViewController: UIViewController {
    @IBOutlet fileprivate weak var reviewCollection: UICollectionView!
    @IBOutlet weak var tryAgainButton: UIButton!
    var anwerArray : [Any] = []
    var questionList : [TestModel]?
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: CollectionViewCellIdentifiers.reviewAnswersCell, bundle:nil)
        reviewCollection.register(nibName, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.reviewAnswersCell)
        
        let nibName2 = UINib(nibName: CollectionViewCellIdentifiers.tryAgainCell, bundle:nil)
        reviewCollection.register(nibName2, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.tryAgainCell)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Actions
    
    @IBAction func tryAgainAction(_ sender: Any) {
    }
    
    @IBAction func homeAction(_ sender: Any) {
    }
    
    @IBAction func backAction(_ sender: Any) {
    }
}


extension ReviewAnswersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, TryAgainDelegate {
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (questionList?.count)! + 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < (questionList?.count)!{
            let cell: ReviewAnswersCell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCellIdentifiers.reviewAnswersCell, for: indexPath) as! ReviewAnswersCell
            cell.setupWithTest(test: (questionList?[indexPath.row])!, number: indexPath.row + 1)
            return cell
        }else{
            let cell: TryAgainCell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCellIdentifiers.tryAgainCell, for: indexPath) as! TryAgainCell
            cell.delegate = self
            return cell
        }
    }
    
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row < (questionList?.count)!{
            let data = (questionList?[indexPath.row].text)!
            
            let data2 = (questionList?[indexPath.row].selectedAnswer?.text)!
            
            
            let constraintRect = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.height/3)
            
            let boundingBox2 = data2.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            let boundingBox3 = "Test Number".boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            
            let boundingBox = data.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            return CGSize.init(width: (collectionView.frame.size.width), height: (boundingBox.height + 5 * 10 + boundingBox2.height + boundingBox3.height))
        }
        return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height/5)
        
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.questionTestViewController) as! QuestionTestViewController
            vc.questionnaire_id = indexPath.row+1
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.questionTestViewController) as! QuestionTestViewController
            vc.questionnaire_id = indexPath.row+1
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        default: break
        }
        
    }
    
    // MARK: - TryAgainDelegate
    
    
    func tryAgain() {
        for vc in (self.navigationController?.viewControllers)! {
            if vc.isKind(of: QuestionTestViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
}
