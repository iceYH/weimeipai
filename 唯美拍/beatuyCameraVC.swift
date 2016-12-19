//
//  beatuyCameraVC.swift
//  唯美拍
//
//  Created by WuYuHeng on 16/12/19.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import Foundation
import UIKit

class beatuyCameraVC: UIViewController{
    override func viewDidLoad() {
          super.viewDidLoad()
        let launchview = YHLaunchView(frame:CGRect(x: 0, y:0 , width: self.view.bounds.size.width, height: self.view.bounds.size.height)
, launchImage: UIImage(named: "LaunchBackgroundImage"))
        
        
        view.addSubview(launchview)
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("test")
            launchview.starAnimation()
        }
        
        

        
        

    }
}
