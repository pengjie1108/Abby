//
//  PJStatusPictureView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/14.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

/// cell 可重用标识符
private let CELLID = "reuseIdentifier"
/// cell 间距
private let itemMargin: CGFloat = 5
/// cell 单位宽高
private let cellWH = (ScreenWidth - 2 * HOMECELLMARGIN - 2 * itemMargin) / 3


class PJStatusPictureView: UICollectionView {

    var picUrls: [PJPictureUrlsModel]?{
        didSet{
            print("图片数量:",picUrls!.count)
            //计算配图需要的尺寸
//            let size = dealPictureViewSize(count: picUrls!.count)
            let size = dealPictureViewSize(count: 9)
            //更新计算后的 size
            self.snp.updateConstraints { (make) in
                make.size.equalTo(size)
            }
        }
    }
    
    private func dealPictureViewSize(count: Int) -> CGSize{
        //计算行数列数
        let row = count == 4 ? 2 : (count - 1) / 3 + 1    //行
        let col = count == 4 ? 2 : count >= 3 ? 3 : count //列
        //计算配图的宽度和长度
        let w = CGFloat(col) * cellWH + CGFloat(col - 1) * itemMargin
        let h = CGFloat(row) * cellWH + CGFloat(row - 1) * itemMargin
        
        return CGSize(width: w, height: h)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        //设置 itemSize
        flowLayout.itemSize = CGSize(width: cellWH, height: cellWH)
        //设置垂直和水平间距
        flowLayout.minimumLineSpacing = itemMargin
        flowLayout.minimumInteritemSpacing = itemMargin
        super.init(frame: frame, collectionViewLayout: flowLayout)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = randomColor()
        //设置代理
        dataSource = self
        //注册 cell
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: CELLID)
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
}

extension PJStatusPictureView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELLID, for: indexPath)
        cell.backgroundColor = randomColor()
        return cell
    }
}

