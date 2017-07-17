//
//  MapBottomView.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/11/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
protocol BottomViewDelegate {
    func updayeHeight()
}
class MapBottomView: UIView {

    @IBOutlet private weak var mainBottomLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var postCodeLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var faxLabel: UILabel!
    
    @IBOutlet private weak var moreButton: UIButton!
    
    @IBOutlet private weak var emailLabel: UILabel!
    
    var delegate :BottomViewDelegate?
    
        @IBInspectable var borderWidth: CGFloat = 0.5 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    class func fromNib<T : MapBottomView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    
    // MARK: - PublicMethods
    
    func setWithBranches(branch: BranchModel) {
        self.mainBottomLabel.text   = branch.title
        self.addressLabel.text      = branch.address
        self.postCodeLabel.text     = "P.O.Box: " + branch.postal_code!
        self.phoneLabel.text        = branch.phone
        self.faxLabel.text          = branch.fax
        self.emailLabel.text        = branch.email        
    }
    
    
    
    // MARK: - Actions
    
    
    @IBAction func moreAction(_ sender: Any) {
        delegate?.updayeHeight()
    }
    
    @IBAction func makePathAction(_ sender: Any) {
    }
    
}
