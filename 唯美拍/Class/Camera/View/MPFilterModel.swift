//
//  MPFilterModel.swift
//  唯美拍
//
//  Created by cdh on 2016/12/28.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import UIKit
import GPUImage
import RxSwift
class MPFilterModel :NSObject {

    var image : String = ""
    var filter : GPUImageFilter?
    var title : String = ""
    
    init(imageString : String , titleStr : String) {
        super.init()
        image = imageString
        title = titleStr
    }
    
    
//   fileprivate func filterModel(image:String , filter:GPUImageFilter) -> MPFilterModel {
//        let filterModel : MPFilterModel = MPFilterModel()
//        filterModel.image = image
//        filterModel.filter = filter;
//        return filterModel
//    }
}
