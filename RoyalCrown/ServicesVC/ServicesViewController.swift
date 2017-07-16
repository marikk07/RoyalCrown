//
//  ServicesViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/16/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var servicesCollection: UICollectionView!
    fileprivate let cellsImgArry = ["business_image","personal_image"]
    fileprivate let cellsTitlesArray = ["BUSINESS", "PERSONAL"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName:CollectionViewCellIdentifiers.mainCell, bundle:nil)
        self.servicesCollection.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.mainCell)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        
        let cellHeight:CGFloat = collectionView.frame.height/2 - 5
        var cellWidth:CGFloat = collectionView.frame.width
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    // MARK - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.servicesListViewController) as! ServicesListViewController
        switch indexPath.row {
        case 0:
            vc.serviceType = Service.business
            
        case 1:
           vc.serviceType =  Service.personal
        default: break
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
