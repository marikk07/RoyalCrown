//
//  AboutRoyalAssistViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/5/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AboutRoyalAssistViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RestManager().getAboutRoyalAssist { (message, error) in
            if message != nil {
                self.webView.scrollView.bounces = false;
                let messageWithColor = "<div style='color:#302B80'>" + (message as! String) + "</div>"
                self.webView.loadHTMLString(messageWithColor, baseURL: nil)
            
            }
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
