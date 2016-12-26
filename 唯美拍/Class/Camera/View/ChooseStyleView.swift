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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showStyleView() {
        
    }
    func hideStyleView(){
        
    }
}
extension ChooseStyleView {
    fileprivate func setView(){
        print("创建来了VIEW")
    }
    
    fileprivate func showView() {
    
    }
}
