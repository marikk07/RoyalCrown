//
//  RoyalAssistViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/4/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class RoyalAssistViewController: UIViewController {
    @IBOutlet weak var royalCollectionView: UICollectionView!

    fileprivate let cellsImgArry = ["royal_assist_image","royal_payment_image","services_image"]
    fileprivate let cellsTitlesArray = ["REPORT AN ACCIDENT", "MAKE A CALL", "ABOUT ROYAL ASSIST"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "MainCell", bundle:nil)
        self.royalCollectionView.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.mainCell)
    }
    
     // MARK - Acions
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func homeAction(_ sender: Any) {
         self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK
    
    func showCallAlert(){
        AlertHelper.showAlert(title:extraPhoneNumber, message:"", buttons: [cancelCall, makeCall], completion: { (tapButtonTitle) in
            if tapButtonTitle == makeCall{
                let phoneNumberUrl = URL.init(string:"tel://"+extraPhoneNumber)
                UIApplication.shared.open(phoneNumberUrl!, options: [:], completionHandler: nil)
            }
            
        })
    }
}

extension RoyalAssistViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        
        let cellHeight:CGFloat = collectionView.frame.height/3
        let cellWidth:CGFloat = collectionView.frame.width
        
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    // MARK - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case  0:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.accidentReportViewController) as! AccidentReportViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            self.showCallAlert()
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.aboutRoyalViewController) as! AboutRoyalAssistViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default: break
        }
        
    }
}
