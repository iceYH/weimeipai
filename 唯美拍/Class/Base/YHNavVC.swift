//
//  YHNavVC.swift
//  唯美拍
//
//  Created by WuYuHeng on 16/12/19.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import UIKit

class YHNavVC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        // 1.取出手势&view
        guard let gesture = interactivePopGestureRecognizer else { return }
        gesture.isEnabled = false
        let gestureView = gesture.view
        
        // 2.获取所有的target
        let target = (gesture.value(forKey: "_targets") as? [NSObject])?.first
        guard let transition = target?.value(forKey: "_target") else { return }
        let action = Selector(("handleNavigationTransition:"))
        
        // 3.创建新的手势
        let popGes = UIPanGestureRecognizer()
        popGes.maximumNumberOfTouches = 1
        gestureView?.addGestureRecognizer(popGes)
        popGes.addTarget(transition, action: action)
        
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {        
        super.pushViewController(viewController, animated: animated)
    }
    
}
