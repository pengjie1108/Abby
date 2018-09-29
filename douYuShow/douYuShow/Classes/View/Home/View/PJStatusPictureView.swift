//
//  PJStatusPictureView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/14.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import SDWebImage

/// cell 可重用标识符
private let CELLID = "reuseIdentifier"
/// cell 间距
private let itemMargin: CGFloat = 5
/// cell 单位宽高
private let cellWH = (ScreenWidth - 2 * HOMECELLMARGIN - 2 * itemMargin) / 3

class PJStatusPictureView: UICollectionView {

    var picUrls: [PJPictureUrlsModel]?{
        didSet{
//            print("图片数量:",picUrls!.count)
            //计算配图需要的尺寸
            let size = dealPictureViewSize(count: picUrls!.count)
            //更新计算后的 size
            self.snp.updateConstraints { (make) in
                make.size.equalTo(size)
            }
            //设置 layout
            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            if picUrls!.count == 1{
                layout.itemSize = size
            }else {
                layout.itemSize = CGSize(width: cellWH, height: cellWH)
            }
            //需要进行 layoutIfNeed 同步 itemsize 和配图大小.
            layoutIfNeeded()
            //刷新 UI
            reloadData()
        }
    }
    
    private func dealPictureViewSize(count: Int) -> CGSize{
        //如果是一张图片
        if count == 1 {
            //判断图片地址是否为 nil
            if let thumbnail_pic = picUrls?.first?.thumbnail_pic{
                //通过图片地址得到本地对应的图片
                let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: thumbnail_pic)
                //如果为 image
                if let img = image{
                   //取得图片真实大小
                    var imgW = img.size.width
                    var imgH = img.size.height
                    //如果宽度小于80
                    if imgW < 80{
                        imgW = 80
                    }
                    //如果高度大于150
                    if imgH > 150{
                        imgH = 150
                    }
                     return CGSize(width: imgW, height: imgH)
                }
            }
            
            
            
            
        }
        
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
        backgroundColor = UIColor.clear
        //设置代理
        dataSource = self
        //注册 cell
        register(PJStatusPictureViewCell.self, forCellWithReuseIdentifier: CELLID)
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
}

extension PJStatusPictureView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELLID, for: indexPath) as! PJStatusPictureViewCell
        cell.pictureUrlModel = picUrls![indexPath.item]
        return cell
    }
}



/// 配图 cell
class PJStatusPictureViewCell: UICollectionViewCell {
    
    /// 模型属性,供外界赋值
    var pictureUrlModel: PJPictureUrlsModel?{
        didSet{
            //图片赋值
            bgImageView.pj_setImage(urlString: pictureUrlModel?.thumbnail_pic, placeholderImgName: "avatar_default_big")
            //gif 赋值
            if let thumbnail_pic = pictureUrlModel?.thumbnail_pic, thumbnail_pic.hasSuffix(".gif"){
                //显示 gif
                gifImageView.isHidden = false
            }else {
                //隐藏 gif
                gifImageView.isHidden = true
            }
        }
    }
    
    ///  配图图片
    private lazy var bgImageView: UIImageView = {
        let img = UIImageView(imgName: "avatar_default_big")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    /// 配图 gif
    private lazy var gifImageView: UIImageView = UIImageView(imgName: "timeline_image_gif")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 配图 cell 的 UI 设置
    private func setupUI(){
        backgroundColor = UIColor.white
        //1添加控件
        contentView.addSubview(bgImageView)
        contentView.addSubview(gifImageView)
        //2添加约束
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        gifImageView.snp.makeConstraints { (make) in
            make.top.right.equalTo(contentView)
        }
    }
}

