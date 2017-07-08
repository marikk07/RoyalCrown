//
//  AboutViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/5/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    let cellCount = 3
    let cellsImgArry = ["royal_assist_image","royal_payment_image","services_image"]
    let cellsTitlesArray = ["ABOUT US", "BRANCHES", "E-NSURED"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "MainCell", bundle:nil)
        self.homeCollectionView.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.mainCell)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.mainCell, for: indexPath) as!MainCell
        cell.fillCellWithImageAndTitle(image: (UIImage.init(named: cellsImgArry[indexPath.row]))!, title: cellsTitlesArray[indexPath.row])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch indexPath.row {
        case 0:  break
            
        case 1:
            let vc = storyboard.instantiateViewController(withIdentifier:ViewControllersIdentifiers.mapViewController) as! GoogleMapViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2: break
            
        default: break
        }
        
    }
    
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight:CGFloat = collectionView.frame.height/3
        let cellWidth:CGFloat = collectionView.frame.width
        
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    
    
    
    
    
    
    
    
    // MARK - Actions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
