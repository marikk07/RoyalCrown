//
//  GoogleMapViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/5/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class GoogleMapViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet fileprivate  weak var mapView: GMSMapView!
    @IBOutlet fileprivate var backgroundView: UIView!
    fileprivate weak var bottomView : MapBottomView? = nil
    fileprivate var heightConst : NSLayoutConstraint?
    private var brachArray : [Any] = []
    fileprivate var markersArray : [Marker] = []
    var locationManager = CLLocationManager()
    private var didFindMyLocation = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bottomView = MapBottomView.fromNib()
        bottomView?.delegate = self
        mapView.addSubview(bottomView!)
        setConstraightsTp(bottomView: bottomView!)
        
        RestManager().branches { (branchArray, error) in
            if (error == nil) {
                self.brachArray = branchArray as! [Any]
                self.setMapView()
                self.bottomView?.setWithBranches(branch: self.brachArray.first as! BranchModel)
            }
        }
        
    }
    
    
    deinit {
        mapView.removeObserver(self, forKeyPath: "myLocation")
    }
    
    
    
    // MARK - Actions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: Private mathods
    func setConstraightsTp(bottomView: UIView) {
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: bottomView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: bottomView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0).isActive = true
        heightConst = NSLayoutConstraint(item: bottomView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.0, constant: CGFloat(ConstraightConst.mapBottomCloseConst))
        heightConst?.isActive = true
        
    }
    
    func setMapView(){
        self.mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.isMyLocationEnabled = true;
        self.locationManager.startUpdatingLocation()
        // mapView.myLocation?.coordinate.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        for branch in brachArray {
            let cord =  CLLocationCoordinate2DMake((branch as! BranchModel).latitude!, (branch as! BranchModel).longitude!);
            let marker = Marker.init(position: cord)
            marker.branchModel = branch as! BranchModel
            marker.icon  = UIImage.init(named: "pin_passive_icon")
            marker.map = mapView
            markersArray.append(marker)
        }
        mapViewPreparing()
        
    }
    
    func mapViewPreparing() {
        mapView.selectedMarker = markersArray.last as GMSMarker?
        
        let path = GMSMutablePath()
        for marker in markersArray {
            path.add((marker as GMSMarker).position)
        }
        if ((mapView.myLocation?.coordinate) != nil) {
            path.add((mapView.myLocation?.coordinate)!)
        }
        let bounds = GMSCoordinateBounds.init(path: path);
        mapView.animate(with:  GMSCameraUpdate.fit(bounds))
    }
    
    
    func updateBottomView(marker :Marker) {
        bottomView?.setWithBranches(branch: marker.branchModel)
    }
    
    
    //MARK: - this is function for create direction path, from start location to desination location
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation) {
        RestManager().drawMapsPath(startLocation: startLocation, endLocation: endLocation) { (routes, error) in
            if ((error != nil)){
                for route in routes as! [JSON]
                {
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 4
                    polyline.strokeColor = UIColor.red
                    polyline.map = self.mapView
                }
            }
        }
    }
    
}


extension GoogleMapViewController: CLLocationManagerDelegate, BottomViewDelegate {
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            locationManager.stopUpdatingLocation()
            mapViewPreparing()
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        marker.icon = UIImage.init(named: "pin_active_icon")
        self.updateBottomView(marker: marker as! Marker)
        unselectMarkers()
        
        let mark = marker as! Marker
        
        
        self.drawPath(startLocation: mapView.myLocation!, endLocation: CLLocation.init(latitude: mark.branchModel.latitude!, longitude: mark.branchModel.longitude!))
        
        
        return true
    }
    
    func unselectMarkers() {
        for superMarker in markersArray {
            if mapView.selectedMarker != superMarker {
                superMarker.icon = UIImage.init(named:"pin_passive_icon")
            }
        }
    }
    
    
    
    
    
    // MARK : BottomViewDelegate
    
    func updayeHeight() {
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConst?.constant = CGFloat(self.heightConst?.constant == CGFloat(ConstraightConst.mapBottomCloseConst) ? ConstraightConst.mapBottomOpenConst : ConstraightConst.mapBottomCloseConst)
            
            self.view?.layoutIfNeeded()
        })
        
        
    }
    
}

