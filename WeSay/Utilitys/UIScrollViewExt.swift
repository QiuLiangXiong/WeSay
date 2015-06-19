//
//  UIScrollViewExt.swift
//  WeSay
//
//  Created by QLX on 15/6/18.
//  Copyright (c) 2015年 qlx. All rights reserved.
//

import UIKit

extension UIScrollView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delaysContentTouches=false
    }
}
