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
import RxSwift
import RxCocoa

class mainViewController: UIViewController {
    fileprivate var bag : DisposeBag = DisposeBag()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
}
extension mainViewController{
     fileprivate func setUpUI() {
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
        camerabtn.rx.tap.subscribe { (event: Event<()>) in
            let beatuyVC :UIViewController = beatuyCameraVC()
            self.navigationController?.pushViewController(beatuyVC, animated: true)
            }.addDisposableTo(bag)
    }
}


