//
//  AboutViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/5/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
  fileprivate  let cellsImgArry = ["royal_assist_image","royal_payment_image","services_image"]
  fileprivate  let cellsTitlesArray = ["ABOUT US", "BRANCHES", "E-NSURED"]
    
    
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
 
    // MARK - Actions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension AboutViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsImgArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.mainCell, for: indexPath) as!MainCell
        cell.fillCellWithImageAndTitle(image: (UIImage.init(named: cellsImgArry[indexPath.row]))!, title: cellsTitlesArray[indexPath.row])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.aboutUsViewController) as! AboutUsViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.mapViewController) as! GoogleMapViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            UIApplication.shared.openURL(URL(string: "https://cw.royalcrowninsurance.eu/Login.aspx?ReturnUrl=%2f")!)
        default: break
        }
        
    }
    
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight = collectionView.frame.height/3.0
        let cellWidth = collectionView.frame.width
        
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
}
