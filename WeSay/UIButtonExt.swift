//
//  UIButtonExt.swift
//  WeSay
//
//  Created by QLX on 15/6/19.
//  Copyright (c) 2015年 qlx. All rights reserved.
//

import UIKit

extension UIButton {
    func setRoundBg(cornerRadius:CGFloat,color:UIColor,titleColor:UIColor=UIColor.whiteColor()){
        self.backgroundColor=color
        self.layer.cornerRadius=cornerRadius
        self.setTitleColor(titleColor, forState: UIControlState.Normal)
        self.layer.masksToBounds=true
    }
    
}
