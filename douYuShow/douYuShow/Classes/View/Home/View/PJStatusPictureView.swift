//
//  PJStatusPictureView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/14.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJStatusPictureView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewLayout()
        super.init(frame: frame, collectionViewLayout: flowLayout)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = randomColor()
    }
}
