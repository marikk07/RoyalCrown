//
//  ServicesListViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/16/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class ServicesListViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tittleLabel: UILabel!
    @IBOutlet fileprivate weak var servicesTable: UITableView!
    fileprivate var servicesArray: [ServiceModel]? = []
    var serviceType: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName:TableViewCellIdentifiers.servicesListCell, bundle:nil)
        self.servicesTable.register(nibName, forCellReuseIdentifier: TableViewCellIdentifiers.servicesListCell)
        
        RestManager().getServices(type: serviceType!) { (array, error) in
            if array != nil {
                self.servicesArray = array as! [ServiceModel]?
                self.servicesTable.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if serviceType == Service.business {
            tittleLabel.text = "Business"
        }else{
            tittleLabel.text = "Personal"
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension ServicesListViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return (servicesArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ServicesListCell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.servicesListCell, for: indexPath) as! ServicesListCell
        cell.setupWith(service: (servicesArray?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.serviceDescriptViewController) as! ServiceDescriptViewController
        vc.service = servicesArray?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
