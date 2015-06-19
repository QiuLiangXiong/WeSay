//
//  AlamofireExt.swift
//  test3
//
//  Created by qlx on 15/6/11.
//  Copyright (c) 2015年 邱良雄. All rights reserved.
//

import UIKit
import Alamofire


class AlamofireExt : NSObject{
    
    
    class func upload(urlString: String, fileName: String ,parameters :[String : String])-> Request{
        
        var path=NSBundle.mainBundle().pathForResource(fileName, ofType: nil)
        var url=NSURL(fileURLWithPath: path!)
        var data=NSData(contentsOfURL: url!)
        let urlRequest = urlRequestWithComponents(urlString, parameters: parameters, data: data!)
        
        return Alamofire.upload(urlRequest.0, urlRequest.1)
    }
    
    class func upload(urlString: String, fileData : NSData ,parameters :[String : String])-> Request{
        
        let urlRequest = urlRequestWithComponents(urlString, parameters: parameters, data: fileData)
        
        return Alamofire.upload(urlRequest.0, urlRequest.1)
    }
        
    
    class func urlRequestWithComponents(urlString:String, parameters:[String:String], data:NSData) -> (URLRequestConvertible, NSData) {
        // create url request to send
        var mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        mutableURLRequest.HTTPMethod = Method.POST.rawValue
        let boundaryConstant = "myRandomBoundary12345";
        let contentType = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        // create upload data to send
        let uploadData = NSMutableData()
        
        // add image
        uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Disposition: form-data; name=\"file\"; filename=\"file.png\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Type: image/png\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData(data)
        
        // add parameters
        
        for (key, value) in parameters {
            uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        // return URLRequestConvertible and NSData
        return (ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
    }
}
