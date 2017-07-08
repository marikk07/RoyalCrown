//
//  AccidentReportViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/5/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AccidentReportViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "PhotoCell", bundle:nil)
        self.photoCollectionView.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.photoCell)
    }


    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.photoCell, for: indexPath) as! PhotoCell
        cell.setUpWithImage(image: UIImage.init(named: "add_photo_icon")!)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.cameraViewController) as! CameraViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK - Acions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    


}
