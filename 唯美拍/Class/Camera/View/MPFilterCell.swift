//
//  MPFilterCell.swift
//  唯美拍
//
//  Created by cdh on 2016/12/28.
//  Copyright © 2016年 WuYuHeng. All rights reserved.
//

import UIKit
import SnapKit
class MPFilterCell: UICollectionViewCell {
    
    
    
    lazy var imageView : UIImageView = {
        let imageView : UIImageView = UIImageView(frame: self.bounds)
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        
        let titleLabel : UILabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 11)
        titleLabel.textColor = .white
        titleLabel.text = "卡通动画"
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        return titleLabel
    }()
    
    var model : MPFilterModel?
        {
        didSet{
            titleLabel.text = model?.title
            imageView.image = UIImage(named: (model?.image)!)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView .addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(frame.size.width)
            make.height.equalTo(frame.size.height - 20)
            make.top.equalTo(self.contentView)
        }
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(frame.size.width)
            make.height.equalTo(20)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
