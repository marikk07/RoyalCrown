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
    @IBOutlet  weak var mapView: GMSMapView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var mainBottomLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var postCodeLabel: UILabel!
    @IBOutlet private weak var lattitudeLabel: UILabel!
    @IBOutlet private weak var longtitudeLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    @IBOutlet private weak var bottomViewHeightContstraight: NSLayoutConstraint!
    
    private var brachArray : NSArray = []
    private var markersArray : NSMutableArray = []
    
    var locationManager = CLLocationManager()
   private var didFindMyLocation = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RestManager().branches { (branchArray, error) in
            if (error == nil) {
                self.brachArray = branchArray as! NSArray
                self.setMapView()
            }
        }
    }
    
    deinit {
        mapView.removeObserver(self, forKeyPath: "myLocation")
    }


    func setMapView(){
        self.mapView.delegate = self
        self.mapView.addSubview(self.bottomView)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.isMyLocationEnabled = true;
        self.locationManager.startUpdatingLocation()
        
        for branch in brachArray {
             let cord =  CLLocationCoordinate2DMake((branch as! BranchModel).latitude!, (branch as! BranchModel).longitude!);
            let marker = Marker.init(position: cord)
            marker.branchModel = branch as! BranchModel
            marker.icon  = UIImage.init(named: "pin_passive_icon")
            marker.map = mapView
            markersArray.add(marker)
            
        }
        
        mapView.selectedMarker = markersArray.lastObject as! GMSMarker?
        
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
    
        let path = GMSMutablePath.init()
        for marker in markersArray {
            path.add((marker as! GMSMarker).position)
        }
        let bounds = GMSCoordinateBounds.init(path: path);
        mapView.animate(with:  GMSCameraUpdate.fit(bounds))

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

    @IBAction func makeDirection(_ sender: Any) {
        

    }

    func updateBottomView(marker :Marker) {
        mainBottomLabel.text = marker.branchModel.title
        addressLabel.text = marker.branchModel.address
         postCodeLabel.text = marker.branchModel.postal_code
         lattitudeLabel.text = String(describing: marker.branchModel.latitude)
         longtitudeLabel.text = String(describing: marker.branchModel.longitude)
         emailLabel.text = marker.branchModel.email
         bottomViewHeightContstraight.constant =  CGFloat(ConstraightConst.mapBottomOpenConst)
    }
    
}

extension GoogleMapViewController: CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.isMyLocationEnabled = true
        }
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

    }
    
     func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        marker.icon = UIImage.init(named: "pin_active_icon")
        self.updateBottomView(marker: marker as! Marker)
        
        return true
    }
}

