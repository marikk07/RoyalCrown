//
//  TestProgressView.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/13/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit

protocol TestProgressViewDelegate {
    func previous()
    func next()
}

class TestProgressView: UIView {
    var testNumber : NSInteger?
    var delegate :TestProgressViewDelegate?
    @IBOutlet weak var progressCollection: UICollectionView!
    
    class func fromNib<T : TestProgressView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nibName = UINib(nibName: "TestProgressCell", bundle:nil)
        self.progressCollection.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.testProgressCell)
    }
    
    //MARK: Actions
    
    @IBAction func previousAction(_ sender: Any) {
        delegate?.previous()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        delegate?.next()
    }


}

extension TestProgressView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TestProgressCell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCellIdentifiers.testProgressCell, for: indexPath) as! TestProgressCell
        if indexPath.row == testNumber {
            cell.isActive = true
        }else if indexPath.row < testNumber! {
            cell.wasActive = true
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight:CGFloat = (collectionView.frame.size.width - 50)/10.0
        let cellWidth:CGFloat = (collectionView.frame.size.width - 50)/10.0

        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
}
