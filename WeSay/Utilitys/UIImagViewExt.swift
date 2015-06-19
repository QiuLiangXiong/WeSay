//
//  UIImagViewExt.swift
//  test3
//
//  Created by qlx on 15/6/9.
//  Copyright (c) 2015年 邱良雄. All rights reserved.
//

import UIKit
import Alamofire


extension UIImageView{
    func setImageWithUrlString(urlString :String){
        Alamofire.request(.GET, urlString).response { (_, _, data, error) -> Void in
            if(error != nil){
                println("setImageWithUrlString error")
            }else{
                var image=UIImage(data: data as! NSData)
                self.image=image
            }
        }
    }
    convenience init(name:String , frame :CGRect){
        self.init(frame: frame)
        self.image=UIImage(named: name)
    }
    convenience init(name:String){
        self.init()
        self.image=UIImage(named: name)
    }
    convenience init(name:String ,contentMode:UIViewContentMode){
        self.init(name: name)
        self.contentMode=contentMode
    }
}
