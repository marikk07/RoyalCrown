//
//  AccidentDesctiptViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/16/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AccidentDesctiptViewController: UIViewController {
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var viewWithButtons: UIView!
    @IBOutlet private weak var buttonsViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var webView: UIWebView!
    
    var accident : AccidentInstructionsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topLabel.text = accident?.title
        self.webView.scrollView.bounces = false;
        
        if accident?.tabs == true {
            leftButton.setTitle(accident?.tab_1_title, for: .normal)
            rightButton.setTitle(accident?.tab_2_title, for: .normal)
            leftSetup()
        }else{
            buttonsViewHeight.constant = 0
            viewWithButtons.isHidden = true
            let messageWithColor = "<div style='color:#302B80'>" + (accident?.tab_1_content)! + "</div>"
            self.webView.loadHTMLString(messageWithColor, baseURL: nil)
        }


    }

    
    
    //MARK: - Actions
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        leftSetup()
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        rightSetup()
    }
    

    func leftSetup()  {
        leftButton.setTitleColor(UIColor.white, for: .normal)
        leftButton.backgroundColor = ColorsConst.violet
        rightButton.setTitleColor(ColorsConst.violet, for: .normal)
        rightButton.backgroundColor = UIColor.white
        
        let messageWithColor = "<div style='color:#302B80'>" + (accident?.tab_1_content)! + "</div>"
        self.webView.loadHTMLString(messageWithColor, baseURL: nil)
        
    }
    func rightSetup()  {
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.backgroundColor = ColorsConst.violet
        
        leftButton.setTitleColor(ColorsConst.violet, for: .normal)
        leftButton.backgroundColor = UIColor.white
        
        let messageWithColor = "<div style='color:#302B80'>" + (accident?.tab_2_content)! + "</div>"
        self.webView.loadHTMLString(messageWithColor, baseURL: nil)
    }
    
}
