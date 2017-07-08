//
//  GoogleMapViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/5/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomViewHeightContstraight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setMapView()

    }
    
    
    func setMapView(){
        self.mapView.delegate = self
        mapView.isMyLocationEnabled = true
        self.mapView.isMyLocationEnabled = true
        
        self.mapView.addSubview(self.bottomView)
    }
    
    
    
    
    
    // MARK - Actions
    @IBAction func moreAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomViewHeightContstraight.constant = CGFloat(self.bottomViewHeightContstraight.constant == CGFloat(ConstraightConst.mapBottomCloseConst) ? ConstraightConst.mapBottomOpenConst : ConstraightConst.mapBottomCloseConst)

            self.view.layoutIfNeeded()
        })
    }
   
    @IBAction func makePathAction(_ sender: Any) {
    }
    
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
