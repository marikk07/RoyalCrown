//
//  ServiceDescriptViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/16/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class ServiceDescriptViewController: UIViewController {
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    var service : ServiceModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topLabel.text = service?.title
        self.webView.scrollView.bounces = false;
        let messageWithColor = "<div style='color:#302B80'>" + (service?.descript)! + "</div>"
        self.webView.loadHTMLString(messageWithColor, baseURL: nil)
    }
    
    //MARK: Actions
    
    @IBAction func goToWebSiteAction(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: (service?.website)!)!)
    }

    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
