//
//  StyleSet.swift
//  WeSay
//  Note:设置系统整体风格 包括字体  和 文本颜色 导航栏的颜色 切换栏的颜色 等 

//  Created by QLX on 15/6/19.
//  Copyright (c) 2015年 qlx. All rights reserved.
//

import UIKit

class StyleSet: NSObject {
    //设置ViewController的风格
    class func setStyleByViewController(root:UIViewController){
        var vc=root as? UINavigationController
        if(vc != nil){
            vc?.navigationBar.barTintColor=UIColor.mainColor()
            vc?.navigationBar.translucent=false
        }
    }
    //设置view的风格
    class func setStyleByView(view :UIView){
        configFont(view)//配置字体
        configFont(view)
    }
    //遍历所有的view  目前没用 留着可能没用
    class func traversalAllView(root:UIView){
        for sub in root.subviews{
            var subView = sub as! UIView
            setStyleByView(subView)
            traversalAllView(subView)
        }
    }
    //配置字体
    class func configFont(view :UIView){
        
        var label=view as? UILabel
        if(label != nil){
            if ((label?.superview as? UITextField) == nil) {
                var fontSize=label?.font.pointSize
                label!.font=UIFont.kaityFontOfSize(fontSize!)
               
                //label!.attributedText
            }
        }
    }
    //配置颜色
    class func configColor(view :UIView){
        view.tintColor=UIColor.blueColor()
    }
}
