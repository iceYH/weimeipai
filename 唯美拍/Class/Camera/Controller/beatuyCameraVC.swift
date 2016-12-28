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
    let bilateralFilter = GPUImageBilateralFilter() // 磨皮
    let exposureFilter = GPUImageExposureFilter() // 曝光
    let brightnessFilter = GPUImageBrightnessFilter() // 美白
    let satureationFilter = GPUImageSaturationFilter() // 饱和
    
    fileprivate lazy var mpFilterView  : MPCameraFilterView = {
        let mpView = MPCameraFilterView(frame:CGRect(x: 0, y: APP_FRAME_HEIGHT - 150, width: APP_FRAME_WIDTH, height: CELL_HEIGHT))
        mpView.isHidden = true
        return mpView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setEnterAnimation()
        setCPUImage()
        setTakePhotoBtn()
        view.addSubview(mpFilterView)
//        setStyleView()
    }
}
extension beatuyCameraVC {
    fileprivate func setTakePhotoBtn(){
        
        let takePhotoBtn:UIButton = UIButton()
        view.addSubview(takePhotoBtn)
        takePhotoBtn.setTitle("拍照", for: .normal)
        takePhotoBtn.rx.tap.subscribe { (event:Event<()>) in
            print("照相")
            self.camera.capturePhotoAsImageProcessedUp(toFilter:self.getGroupFilters(), withCompletionHandler: { (image, error) in
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
        // 3.获取滤镜组
        let filterGroup = getGroupFilters()
        
        // 4.设置GPUImage的响应链
        camera.addTarget(filterGroup)
        
        let showView = GPUImageView(frame: view.bounds)
        view.insertSubview(showView, at: 0)
        filterGroup.addTarget(showView)
        camera.startCapture()
    }
    
    fileprivate func getGroupFilters() -> GPUImageFilterGroup {
        // 1.创建滤镜组（用于存放各种滤镜：美白、磨皮等等）
        let filterGroup = GPUImageFilterGroup()
        
        // 2.创建滤镜(设置滤镜的引来关系)
        bilateralFilter.addTarget(brightnessFilter)
        brightnessFilter.addTarget(exposureFilter)
        exposureFilter.addTarget(satureationFilter)
        
        // 3.设置滤镜组链初始&终点的filter
        filterGroup.initialFilters = [bilateralFilter]
        filterGroup.terminalFilter = satureationFilter
        
        return filterGroup
    }
    
    
    
}
extension beatuyCameraVC{
    @objc fileprivate func takePhoto(){
        print("照相")
        camera.capturePhotoAsImageProcessedUp(toFilter: getGroupFilters(), withCompletionHandler: { (image, error) in
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            self.photoImage.image = image
            self.camera.stopCapture()
        })
    }
    
    }
extension beatuyCameraVC{
    
    @objc fileprivate func chooseStyle(){
        print("选择模式")
        mpFilterView.isHidden = !mpFilterView.isHidden
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
