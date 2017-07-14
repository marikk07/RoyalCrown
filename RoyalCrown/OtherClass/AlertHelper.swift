//
//  AlertHelper.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/4/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    
    typealias AlertCompletion = (_ buttonTitle: String) -> Void
    
    class func showAlert(title: String, message: String?) {
        AlertHelper.showAlert(title: title, message: message, buttons: ["OK"], completion: nil)
    }
    
    class func showAlert(title: String, message: String?, buttons: Array<String>, completion: AlertCompletion?) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for buttonTitle in buttons {
            let buttonAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in
                if let sCompletion = completion {
                    sCompletion(buttonTitle)
                }
            }
            
            alertController.addAction(buttonAction)
        }
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            let rootController: UIViewController? = AlertHelper.topViewController(rootViewController: rootViewController)
            if (rootController != nil) {
                rootController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    class func showAlert(error: NSError) {
        
        let title: String = "Error"
        let message: String = error.localizedDescription
        
        AlertHelper.showAlert(title: title, message: message)
    }
    
    class func showAlert(error: NSError, completion: AlertCompletion?) {
        
        let message: String = error.localizedDescription
        
        AlertHelper.showAlert(title: "Error", message: message, buttons: ["OK"], completion: completion)
    }
    
    
    class func topViewController(rootViewController: UIViewController) -> UIViewController {
        
        guard let presented = rootViewController.presentedViewController else {
            return rootViewController
        }
        
        switch presented {
        case is UINavigationController:
            let navigationController:UINavigationController = presented as! UINavigationController
            return AlertHelper.topViewController(rootViewController: navigationController.viewControllers.last!)
            
        case is UITabBarController:
            let tabBarController:UITabBarController = presented as! UITabBarController
            return AlertHelper.topViewController(rootViewController: tabBarController.selectedViewController!)
            
        default:
            return AlertHelper.topViewController(rootViewController: presented)
        }
    }
}
