//
//  AboutRoyalAssistViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/5/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AboutRoyalAssistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK - Acions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
