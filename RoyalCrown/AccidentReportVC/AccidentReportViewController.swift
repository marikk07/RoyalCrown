//
//  AccidentReportViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/5/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AccidentReportViewController: UIViewController {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var registerNamberField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var agreSwitch: UISwitch!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var firstLine: UIView!
    @IBOutlet weak var secondLine: UIView!
    @IBOutlet weak var thirdLine: UIView!
    
    fileprivate var arrayPhotos : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AccidentReportViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        registCellsNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
    }
    
    
    // MARK: -Private methods
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setUI()  {
        loadViewIfNeeded()
        reportButton.layer.cornerRadius = reportButton.frame.height/2
        agreSwitch.onTintColor = ColorsConst.violet
        agreSwitch.isOn = false
        nameField.delegate = self
        registerNamberField.delegate = self
        phoneField.delegate = self
        
    }
    // MARK: - Acions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reportAction(_ sender: Any) {
        if !(nameField.text?.isEmpty)! && !(registerNamberField.text?.isEmpty)! && !(phoneField.text?.isEmpty)! && agreSwitch.isOn && arrayPhotos.count>0{
            RestManager().reportAccident(name: nameField.text!, policyNamber: registerNamberField.text!, phoneNamber: phoneField.text!, photos: arrayPhotos) { (message, error) in
                if error == nil {
                     AlertHelper.showAlert(title: "Accident report successfully saved" , message: "")
                }
            }
        }

    }
    
    
    // MARK: Private methods
    
    func registCellsNib () {
        let nibName = UINib(nibName: "PhotoCell", bundle:nil)
        self.photoCollectionView.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.photoCell)
        
        let secondNibName = UINib(nibName: "PhotoCellWithCancell", bundle:nil)
        self.photoCollectionView.register(secondNibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.photoCellWithCancell)
    }
}

extension  AccidentReportViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, CameraDelegate, UITextFieldDelegate {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPhotos.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.photoCell, for: indexPath) as! PhotoCell
            cell.setUpWithImage(image: UIImage.init(named: "add_photo_icon")!)
            return cell
        }else{
            let cell: PhotoCellWithCancell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.photoCellWithCancell, for: indexPath) as! PhotoCellWithCancell
            cell.setUpWithImage(image: arrayPhotos[indexPath.row - 1] as! UIImage)
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
            arrayPhotos.remove(at: indexPath.row)
            photoCollectionView.reloadData()
        }
    }
    
    // MARK: CameraDelegate
    
    func fetchPhotos(photosArray: [Any]) {
        arrayPhotos = arrayPhotos + photosArray
        photoCollectionView.reloadData()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            switch textField {
            case nameField:
                firstLine.backgroundColor = ColorsConst.violet
            case registerNamberField:
                secondLine.backgroundColor = ColorsConst.violet
            case phoneField:
                thirdLine.backgroundColor = ColorsConst.violet
            default: break
            }
        } else{
            switch textField {
            case nameField:
                firstLine.backgroundColor = UIColor.lightGray
            case registerNamberField:
                secondLine.backgroundColor = UIColor.lightGray
            case phoneField:
                thirdLine.backgroundColor = UIColor.lightGray
            default: break
            }
        }
        
    }
    
}
