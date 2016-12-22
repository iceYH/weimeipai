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
        let btn:UIButton = UIButton()
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        btn.backgroundColor = .red
        btn.snp.makeConstraints { (make)->Void in
            make.width.height.equalTo(100)
            make.centerX.equalTo(view.bounds.width/2)
            make.bottom.equalTo(-100)
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
        filter.brightness = 0.4
        camera.addTarget(filter)
        
        let showView = GPUImageView(frame: view.bounds)
        view.insertSubview(showView, at: 0)
        filter.addTarget(showView)
        
        camera.startCapture()

    }
    @objc func takePhoto(){
        print("zhaoxiang")
        camera.capturePhotoAsImageProcessedUp(toFilter: filter, withCompletionHandler: { (image, error) in
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            self.photoImage.image = image
            self.camera.stopCapture()
        })
    }
}
