//
//  MPCameraFilterView.swift
//  唯美拍
//
//  Created by cdh on 2016/12/28.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MPCameraFilterView: UIView {

    lazy var collectionV : UICollectionView = {
       
        let layout = MPFilterViewLayOut()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5.0
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.itemSize = CGSize(width: CELL_WIDTH, height: CELL_HEIGHT)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MPCameraFilterView{
    
    fileprivate func setUpUI(){
        collectionV.register(MPFilterCell.self, forCellWithReuseIdentifier: NSStringFromClass(MPFilterCell.self))
        self.addSubview(collectionV);
       
    }
  
}

extension MPCameraFilterView : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionV.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MPFilterCell.self), for: indexPath) as! MPFilterCell
        
        cell.model = MPFilterModel(imageString: "03", titleStr: "煞笔")
        return cell
    }
}

