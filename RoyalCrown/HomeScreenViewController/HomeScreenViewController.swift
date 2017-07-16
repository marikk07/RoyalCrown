//
//  HomeScreenViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/3/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    fileprivate let cellsImgArry = ["royal_assist_image","royal_payment_image","services_image", "what_to_do_if_image", "about_image", "royal_assist_image"]
    
    fileprivate let cellsTitlesArray = ["ROYAL ASSIST", "ROYAL PAYMENT", "SERVICES", "WHAT TO DO IF", "ABOUT", "QUESTIONARIS"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName:CollectionViewCellIdentifiers.mainCell, bundle:nil)
        self.homeCollectionView.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.mainCell)

    }

}

extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsImgArry.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainCell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCellIdentifiers.mainCell, for: indexPath) as! MainCell
        
        cell.fillCellWithImageAndTitle(image: (UIImage.init(named: cellsImgArry[indexPath.row]))!, title: cellsTitlesArray[indexPath.row])
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight:CGFloat = homeCollectionView.frame.height/3
        var cellWidth:CGFloat = homeCollectionView.frame.width/2 - 5
        
        if indexPath.row%3 == 2{
            cellWidth = homeCollectionView.frame.width
        }
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    // MARK - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.royalAssistViewController) as! RoyalAssistViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            UIApplication.shared.openURL(URL(string: "https://www.jccsmart.com/eBills/Welcome/Index/9634031")!)
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.servicesViewController) as! ServicesViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.accidentListViewController) as! AccidentListViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.aboutViewController) as! AboutViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.quizViewController) as! QuizViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        default: break
        }
        
    }
    
}
