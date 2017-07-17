//
//  AccidentListViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/16/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AccidentListViewController: UIViewController {
    @IBOutlet weak var accidentTable: UITableView!

    fileprivate var accidentArray: [AccidentInstructionsModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName:TableViewCellIdentifiers.servicesListCell, bundle:nil)
        self.accidentTable.register(nibName, forCellReuseIdentifier: TableViewCellIdentifiers.servicesListCell)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RestManager().getAccidentInstructions { (accidents, error) in
            self.accidentArray = accidents as! [AccidentInstructionsModel]?
            self.accidentTable.reloadData()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}


extension AccidentListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (accidentArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ServicesListCell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.servicesListCell, for: indexPath) as! ServicesListCell
        cell.setupWith(accident: (accidentArray?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier:ViewControllersIdentifiers.accidentDesctiptViewController) as! AccidentDesctiptViewController
        vc.accident = accidentArray?[indexPath.row]
     //   vc.service = accidentArray?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
