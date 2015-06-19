//
//  UIViewExt.swift
//  WeSay
//
//  Created by qlx on 15/6/16.
//  Copyright (c) 2015年 qlx. All rights reserved.
//

import UIKit

enum KeyPath:String{
    case PositionX = "position.x"
    case PositionY = "position.y"
    case Scale="transform.scale"
    case Rotation="transform.rotation"
    case Opacity="opacity"
    case Margin="margin"
    case BackgroundColor="backgroundColor"
    case CornerRadius="cornerRadius"
    case BorderWidth="borderWidth"
    case Bounds="bounds"
    case Contents="contents"
    case ContentsRect="contentsRect"
    case Position="position"
    case Frame="frame"
    case Hidden="hidden"
    case Mask="mask"
    case MasksToBounds="masksToBounds"
    case ShadowColor="shadowColor"
    case ShadowOffset="shadowOffset"
    case ShadowOpacity="shadowOpacity"
    case ShadowRadius="shadowRadius"
}
extension UIView {
    func addSubviewWithStyleSet(view:UIView){
        self.addSubviewWithStyleSet(view)
        StyleSet.setStyleByView(view)
        
    }
    func animateWithShake(){
        animationWithShake(0.2, force: 0.3, delay: 0.1)
    }
    func animationWithShake(duration: CGFloat , force:CGFloat=1,delay:CGFloat=0){
        var animation=CAKeyframeAnimation(keyPath: "position.x")
      //  animation.keyTimes=[0,0.15,0.3,0.45,0.6,0.8,1]
        var values=[0,30*force,-30*force,30*force,-30*force,30*force ,0]
        animationWithKeyFrame(duration, values: values, keyPath: KeyPath.PositionX,key:"shake", timingFunc: kCAMediaTimingFunctionEaseOut, delay: delay, repeatCount: 0)
    }
    /*
    keyPath
    position.x
    transform.scale = 比例转换
    
    transform.rotation = 旋转
    
    opacity = 透明度
    
    margin = 边距
    
    zPosition
    
    backgroundColor =   背景颜色
    
    cornerRadius   = 圆角
    
    borderWidth
    
    bounds
    
    contents
    
    contentsRect
    
    frame
    
    hidden
    
    mask
    
    masksToBounds
    
    position = 位置
    
    shadowColor
    
    shadowOffset
    
    shadowOpacity
    
    shadowRadius
    */
    func animationWithKeyFrame(duration:CGFloat ,values:[AnyObject],keyPath:KeyPath,key:String,additive:Bool=true,timingFunc:String=kCAMediaTimingFunctionLinear,delay:CGFloat=0,repeatCount:Float=0){
        var animation=CAKeyframeAnimation(keyPath: keyPath.rawValue)
        animation.values=values
        animation.additive=additive  //是否相对变化
        animation.duration=CFTimeInterval(duration)
        animation.beginTime=CACurrentMediaTime()+CFTimeInterval(delay)
        animation.repeatCount=repeatCount
        animation.removedOnCompletion=false
        animation.fillMode=kCAFillModeForwards
        animation.timingFunction=CAMediaTimingFunction(name: timingFunc)
        animation.delegate=self
        animation.setValue(animation, forKey: key)
        self.layer.addAnimation(animation, forKey: key)

    }
    
    func animationWithKeyFrameForEaseOut(duration:CGFloat ,values:[AnyObject],keyPath:KeyPath,key:String,additive:Bool=true){
        animationWithKeyFrame(duration, values: values, keyPath: keyPath,key: key,additive: additive, timingFunc: kCAMediaTimingFunctionEaseOut)
    }
    func animationWithKeyFrameForEaseIn(duration:CGFloat ,values:[AnyObject],keyPath:KeyPath,key:String,additive:Bool=true){
        animationWithKeyFrame(duration, values: values, keyPath: keyPath,key:key, additive: additive,timingFunc: kCAMediaTimingFunctionEaseIn)
    }
    func animationWithKeyFrameForLinear(duration:CGFloat ,values:[AnyObject],keyPath:KeyPath,key:String,additive:Bool=true){
        animationWithKeyFrame(duration, values: values, keyPath: keyPath,key:key,additive: additive, timingFunc: kCAMediaTimingFunctionLinear)
    }
    func animationWithKeyFrameForEaseInEaseOut(duration:CGFloat ,values:[AnyObject],keyPath:KeyPath,key:String,additive:Bool=true){
        animationWithKeyFrame(duration, values: values, keyPath: keyPath,key:key,additive: additive, timingFunc: kCAMediaTimingFunctionEaseInEaseOut)
    }
    
    
}

