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

class beatuyCameraVC: UIViewController{
    var photoImage :UIImageView = UIImageView()
    fileprivate lazy var camera : GPUImageStillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: .front)
    fileprivate lazy var filter = GPUImageBrightnessFilter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setEnterAnimation()
        setCPUImage()
        setTakePhotoBtn()
    }
}
extension beatuyCameraVC {
    fileprivate func setTakePhotoBtn(){
//        setBtn(BtnName: "cameraBtn", titile: "拍照")
        let btn:UIButton = UIButton()
        view.addSubview(btn)
        btn.setTitle("拍照", for: .normal)
        btn.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        btn.backgroundColor = .red
        btn.snp.makeConstraints { (make)->Void in
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
            print("test")
            launchview.starAnimation()
        }
    }
    
    fileprivate func setCPUImage(){
        camera.outputImageOrientation = .portrait
        filter.brightness = 0.2
        camera.addTarget(filter)
        
        let showView = GPUImageView(frame: view.bounds)
        view.insertSubview(showView, at: 0)
        filter.addTarget(showView)
        
        camera.startCapture()

    }
   
    
}
extension beatuyCameraVC{
    @objc fileprivate func takePhoto(){
        print("照相")
        camera.capturePhotoAsImageProcessedUp(toFilter: filter, withCompletionHandler: { (image, error) in
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            self.photoImage.image = image
            self.camera.stopCapture()
        })
    }
    fileprivate func setBtn(BtnName:String,titile:String){
        let BtnName:UIButton = UIButton()
        view.addSubview(BtnName)
        BtnName.setTitle(titile, for: .normal)
        BtnName.backgroundColor = UIColor.radomColor()
//        rotateBtn.addTarget(self, action: #selector(rotate), for: .touchUpInside)
    }
    @objc fileprivate func chooseStyle(){
        print("选择模式")
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
