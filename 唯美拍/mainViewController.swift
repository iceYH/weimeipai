//
//  mainViewController.swift
//  唯美拍
//
//  Created by WuYuHeng on 16/12/19.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class mainViewController: UIViewController {
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = .white
        let camerabtn:UIButton = UIButton()
        camerabtn.backgroundColor = .red
        camerabtn.setTitle("照相机", for: .normal)
        view.addSubview(camerabtn)
        camerabtn.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(100)
            make.center.equalTo(self.view)
        }
        camerabtn.addTarget(self, action: #selector(camerBtnClick), for: .touchUpInside)
        
    }
    
}
extension mainViewController{
    @objc fileprivate func camerBtnClick() {
        let cameraView : CameraStyleView = CameraStyleView(frame: CGRect(x: 0.0, y: 100.0, width: self.view.bounds.width, height: 80.0))
        cameraView.backgroundColor = .red;
        view.addSubview(cameraView)
        
        let beatuyVC :UIViewController = beatuyCameraVC()
        navigationController?.pushViewController(beatuyVC, animated: true)
    }
}
