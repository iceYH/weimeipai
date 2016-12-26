//
//  ChooseStyleView.swift
//  唯美拍
//
//  Created by WuYuHeng on 16/12/26.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChooseStyleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setView()
    }
    func showStyleView() {
        
    }
    func hideStyleView(){
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ChooseStyleView {
    fileprivate func setView(){
        print("创建来了VIEW")
        let styleView: UICollectionView = UICollectionView()
        self.addSubview(styleView)
    }
    
    fileprivate func showView() {
    
    }
}
