//
//  ZLSwiftFootView.swift
//  ZLSwiftRefresh
//
//  Created by 张磊 on 15-3-6.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

import UIKit

class ZLSwiftFootView: UIView {
    
    var footLabel: UILabel = UILabel()
    
    var title:String {
        set {
            footLabel.text = newValue
        }
        
        get {
            return footLabel.text!
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
        var footTitleLabel:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        footTitleLabel.textAlignment = .Center
        footTitleLabel.text = ZLSwithRefreshFootViewText
        self.addSubview(footTitleLabel)
        footLabel = footTitleLabel
    }


}
