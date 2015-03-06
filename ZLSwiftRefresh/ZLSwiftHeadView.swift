//
//  ZLSwiftHeadView.swift
//  ZLSwiftRefresh
//
//  Created by 张磊 on 15-3-6.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

import UIKit

class ZLSwiftHeadView: UIView {
    
    var headLabel: UILabel = UILabel()
    
    var title:String {
        set {
            headLabel.text = newValue
        }
        
        get {
            return headLabel.text!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        // Currently it is not supported to load view from nib
    }
    
    func setupUI(){
        var headTitleLabel:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        headTitleLabel.textAlignment = .Center
        headTitleLabel.text = ZLSwithRefreshHeadViewText
        self.addSubview(headTitleLabel)
        headLabel = headTitleLabel
    }

}
