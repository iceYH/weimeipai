//
//  beatuyCameraVC.swift
//  唯美拍
//
//  Created by WuYuHeng on 16/12/19.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import GPUImage
import RxSwift
import RxCocoa

class beatuyCameraVC: UIViewController{
    var photoImage :UIImageView = UIImageView()
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    fileprivate lazy var camera : GPUImageStillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: .front)
    fileprivate lazy var filter = GPUImageBrightnessFilter()
//    fileprivate let styleView: ChooseStyleView = ChooseStyleView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setEnterAnimation()
        setCPUImage()
        setTakePhotoBtn()
        setStyleView()
    }
}
extension beatuyCameraVC {
    fileprivate func setTakePhotoBtn(){
        
        let takePhotoBtn:UIButton = UIButton()
        view.addSubview(takePhotoBtn)
        takePhotoBtn.setTitle("拍照", for: .normal)
        takePhotoBtn.rx.tap.subscribe { (event:Event<()>) in
            print("照相")
            self.camera.capturePhotoAsImageProcessedUp(toFilter: self.filter, withCompletionHandler: { (image, error) in
                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                self.photoImage.image = image
                self.camera.stopCapture()
            })
        }.addDisposableTo(bag)
        takePhotoBtn.backgroundColor = .red
        takePhotoBtn.snp.makeConstraints { (make)->Void in
            make.width.height.equalTo(100)
            make.centerX.equalTo(view.bounds.width/2)
            make.bottom.equalTo(0)
        }
        
        let styleBtn:UIButton = UIButton()
        view.addSubview(styleBtn)
        styleBtn.setTitle("模式", for: .normal)
        styleBtn.backgroundColor = .gray
        styleBtn.addTarget(self, action: #selector(chooseStyle), for: .touchUpInside)
        styleBtn.snp.makeConstraints { (make)->Void in
            make.width.height.equalTo(100)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        let optionalBtn:UIButton = UIButton()
        view.addSubview(optionalBtn)
        optionalBtn.setTitle("自定义", for: .normal)
        optionalBtn.backgroundColor = .green
        optionalBtn.addTarget(self, action: #selector(optionalStyle), for: .touchUpInside)
        optionalBtn.snp.makeConstraints { (make)->Void in
            make.width.height.equalTo(100)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        let rotateBtn:UIButton = UIButton()
        view.addSubview(rotateBtn)
        rotateBtn.setTitle("旋转", for: .normal)
        rotateBtn.backgroundColor = .red
        rotateBtn.addTarget(self, action: #selector(rotate), for: .touchUpInside)
        rotateBtn.snp.makeConstraints { (make)->Void in
            make.width.height.equalTo(50)
            make.top.equalTo(20)
            make.left.equalTo(0)
        }
        let lightingBtn:UIButton = UIButton()
        view.addSubview(lightingBtn)
        lightingBtn.setTitle("闪光灯", for: .normal)
        lightingBtn.backgroundColor = .red
        lightingBtn.addTarget(self, action: #selector(lighting), for: .touchUpInside)
        lightingBtn.snp.makeConstraints { (make)->Void in
            make.width.height.equalTo(50)
            make.top.equalTo(20)
            make.centerX.equalTo(view.bounds.width/2)
        }
    }
    fileprivate func setUpUI(){
        view.addSubview(photoImage)
        photoImage.snp.makeConstraints { (make)-> Void in
            make.top.left.bottom.right.equalTo(0)
        }
    }
    
    fileprivate func setEnterAnimation(){
        let launchview = YHLaunchView(frame:CGRect(x: 0, y:0 , width: self.view.bounds.size.width, height: self.view.bounds.size.height), launchImage: UIImage(named: "LaunchBackgroundImage"))
    
        view.addSubview(launchview)
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            launchview.starAnimation()
        }
    }
    fileprivate func setStyleView(){
        let styleView:ChooseStyleView = ChooseStyleView()
        styleView.backgroundColor = UIColor.radomColor()
        view.addSubview(styleView)
        styleView.snp.makeConstraints { (make)-> Void in
            make.bottom.equalTo(-100)
            make.right.left.equalTo(0)
            make.height.equalTo(100)
        }
    }
    
    fileprivate func setCPUImage(){
        camera.outputImageOrientation = .portrait
        camera.horizontallyMirrorFrontFacingCamera = true
//        filter.brightness = 0.2
        camera.addTarget(filter)
        
        let showView = GPUImageView(frame: view.bounds)
        view.insertSubview(showView, at: 0)
        filter.addTarget(showView)
        
        camera.startCapture()

    }
}
extension beatuyCameraVC{

    @objc fileprivate func chooseStyle(){
        print("选择模式")
//        styleView.showStyleView()
    }
    @objc fileprivate func optionalStyle(){
        print("自定义")
    }
    @objc fileprivate func rotate(){
        camera.rotateCamera()
    }
    @objc fileprivate func lighting(){
        print("闪光灯")
    }
}
