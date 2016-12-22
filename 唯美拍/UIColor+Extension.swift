//
//  UIColor+Extension.swift
//  YHScrollowMagic
//
//  Created by WuYuHeng on 16/12/5.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import UIKit

extension  UIColor {
    //r g b转化
    convenience  init(_ r : CGFloat ,_ g : CGFloat,_ b : CGFloat,_ alpha : CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    //随机色
    class func radomColor() -> UIColor{
        return UIColor(CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)))
    }
    // 十六进制转化
    convenience init?(_ hex : String ,alpha : CGFloat = 1) {
        //# ## 0x
        guard hex.characters.count>=6 else {
            return nil
        }
        var tempHex = hex.uppercased()
        
        if tempHex.hasPrefix("##") || tempHex.hasPrefix("0x") {
            tempHex = (hex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("#") {
            tempHex = (hex as NSString).substring(to: 1)
        }
        //转化 FF FF FF
        var range = NSRange(location: 0, length: 2)
        
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        
        let bHex = (tempHex as NSString).substring(with: range)
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        self.init( CGFloat(r), CGFloat(g), CGFloat(b))

        }

}
