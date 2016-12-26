//
//  CameraStyleView.swift
//  唯美拍
//
//  Created by cdh on 2016/12/23.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import UIKit
import GPUImage
class CameraStyleView: UIView {

    var filterArray : [GPUImageFilter]  = [GPUImageSketchFilter(),GPUImageLookupFilter(),GPUImageSepiaFilter()]
    
    lazy var contentScrollView: UIScrollView = {
        let scroll = UIScrollView(frame: self.bounds)
        
        return scroll
    }()
    
    var callBack : ((GPUImageFilter) ->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpCameraView(filterArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CameraStyleView{
    
   fileprivate func setUpCameraView(_ filters : [GPUImageFilter]) {
        
    let titles = ["素描","色彩调整","褐色","黑白色调模糊"]
        for i  in 0...3{
            
            let filterBtn = UIButton()
            filterBtn.backgroundColor = .white
            filterBtn.setTitle(titles[i], for: .normal)
            filterBtn.addTarget(self, action:#selector(filterClick),for: .touchUpInside)

            filterBtn.frame = CGRect(x: i * 80, y: 0, width: 80, height: Int(self.bounds.size.height))
            contentScrollView.addSubview(filterBtn)
        }
        
    }
    
    @objc func filterClick(_ btn : UIButton) {
    
    
    }
}
