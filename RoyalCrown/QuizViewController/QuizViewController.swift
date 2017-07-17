//
//  QuizViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/13/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var quizCollection: UICollectionView!
    fileprivate var questionnaireArray : [QuestionnaireModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "QuizCell", bundle:nil)
        quizCollection.register(nibName, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.quizCell)
        
        RestManager().getQuestionnaires { (questArray, error) in
            if (error == nil) {
                self.questionnaireArray = questArray as! [QuestionnaireModel]
                self.quizCollection.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }

}

extension QuizViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionnaireArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: QuizCell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCellIdentifiers.quizCell, for: indexPath) as! QuizCell
        cell.setupWith(questModel: questionnaireArray[indexPath.row])

        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight:CGFloat = quizCollection.frame.height/3.3
        var cellWidth:CGFloat = quizCollection.frame.width
        
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    // MARK - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.questionTestViewController) as! QuestionTestViewController
            vc.questionnaire_id = indexPath.row+1
            vc.tittleStr = questionnaireArray[indexPath.row].title
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.questionTestViewController) as! QuestionTestViewController
             vc.questionnaire_id = indexPath.row+1
            vc.tittleStr = questionnaireArray[indexPath.row].title
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        default: break
        }
        
    }
 

    
}
