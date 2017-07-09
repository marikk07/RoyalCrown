//
//  AccidentReportViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/5/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AccidentReportViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, CameraDelegate {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    private var photoArray : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registCellsNib()
        photoArray = [UIImage.init(named: "add_photo_icon") as Any]
    }
    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.photoCell, for: indexPath) as! PhotoCell
            cell.setUpWithImage(image: photoArray[indexPath.row] as! UIImage)
            return cell
        }else{
            let cell: PhotoCellWithCancell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.photoCellWithCancell, for: indexPath) as! PhotoCellWithCancell
            cell.setUpWithImage(image: photoArray[indexPath.row] as! UIImage)
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellHeight:CGFloat = photoCollectionView.frame.width/3.5
        var cellWidth:CGFloat = photoCollectionView.frame.width/3.5 
        
        if indexPath.row == 0{
            cellWidth = photoCollectionView.frame.width/6
            cellHeight = photoCollectionView.frame.width/6
        }
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.cameraViewController) as! CameraViewController
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }else{
            photoArray.removeObject(at: indexPath.row)
            photoCollectionView.reloadData()
        }
    }
    
    
    
    // MARK: - Acions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: CameraDelegate
    
    func fetchPhotos(photosArray: NSArray) {
        photoArray.addObjects(from: photosArray as! [Any])
        photoCollectionView.reloadData()
    }
    
    
    // MARK: Private methods
    
    func registCellsNib () {
        let nibName = UINib(nibName: "PhotoCell", bundle:nil)
        self.photoCollectionView.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.photoCell)
        
        let secondNibName = UINib(nibName: "PhotoCellWithCancell", bundle:nil)
        self.photoCollectionView.register(secondNibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.photoCellWithCancell)
    }
    
    
}
