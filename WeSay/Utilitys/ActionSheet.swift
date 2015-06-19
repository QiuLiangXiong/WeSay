//
//  UITableViewExt.swift
//  WeSay
//
//  Created by qlx on 15/6/16.
//  Copyright (c) 2015年 qlx. All rights reserved.
//

import UIKit

class ActionSheet : UITableView ,UITableViewDelegate ,UITableViewDataSource{
    
    
    var cells = [AnyObject]()
    var cellHeight=CGFloat(65)
    var selectedCallabck:((index:Int)->Void)?
    var  bg:UIView!
    init(){
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.delegate=self
        self.dataSource=self
        self.scrollEnabled=false
        self.delaysContentTouches=false
        self.backgroundColor=UIColor(red: 255, green: 255, blue: 255, alpha: 0.2)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCellWithImageAndTextAndLignment(image : UIImage?, text : String ,
        textAlignment:NSTextAlignment=NSTextAlignment.Left,textColor:UIColor=UIColor(red: 68/255, green: 123/255, blue: 220/255, alpha: 1)){
            var cell=UITableViewCell()
            cell.imageView?.image=image
            cell.imageView?.contentMode=UIViewContentMode.Center
            cell.textLabel?.text=text
            cell.textLabel?.textColor=textColor
            cell.textLabel?.font=UIFont(name: "Arial", size: 22)
            cell.textLabel?.textAlignment=textAlignment
            cells.append(cell)
    }
    func addCellWithImageNameAndText(name:String,text:String){
        var image=UIImage(named: name)
        addCellWithImageAndTextAndLignment(image, text: text, textAlignment: .Left)
    }
    func addCellWithText(text:String, textAlignment:NSTextAlignment=NSTextAlignment.Center){
        addCellWithImageAndTextAndLignment(nil, text: text, textAlignment: textAlignment)
    }
    func addCell(cell :UITableViewCell){
        cells.append(cell)
        
    }
    
    func addCellWithButton(name:String,width:CGFloat){
        self.delaysContentTouches=false
        var button=UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        var frame=CGRectMake(0, 0, width-32, cellHeight*0.7  )
        button.frame=frame
        button.center=CGPointMake(width/2, cellHeight/2)
        button.backgroundColor=UIColor(red: 68/255, green: 123/255, blue: 220/255, alpha: 1)
        button.addTarget(self, action: "onButtonTap:", forControlEvents: UIControlEvents.TouchUpInside)
        button.tag=cells.count
        button.setTitle(name, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.layer.cornerRadius=20
        button.layer.masksToBounds=true
        var ddd=button.becomeFirstResponder()
        var cell=UITableViewCell()
        self.separatorColor=UIColor.clearColor()
        cell.addSubview(button)
        //cell.userInteractionEnabled=false
        self.delaysContentTouches=false
        self.allowsSelection = false
        cells.append(cell)
        
    }
    //UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cells[indexPath.row] as! UITableViewCell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCallabck!(index: indexPath.row)
    }
    //
    func show(rootView:UIView){
        var frame=rootView.frame
        self.delaysContentTouches=false
        bg=UIView(frame:rootView.bounds)
        bg.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        bg.animationWithKeyFrameForEaseOut(0.2, values: [0,1], keyPath: KeyPath.Opacity, key: "bgOpacity",additive:false)
        var tap=UITapGestureRecognizer(target: self, action: "onTap")
        bg.addGestureRecognizer(tap)
        
        rootView.addSubview(bg)
        rootView.addSubview(self)
        var height=CGFloat(cells.count)*cellHeight
        self.frame=CGRectMake(0, frame.height-height, frame.width,height)
        self.animationWithKeyFrameForEaseOut(0.2, values: [self.frame.height,0], keyPath: KeyPath.PositionY,key:"come")
        
    }
    func hiden(){
        self.animationWithKeyFrameForEaseIn(0.2, values: [0,self.frame.height], keyPath: KeyPath.PositionY,key:"out")
        bg.animationWithKeyFrameForEaseIn(0.2, values: [1,0], keyPath: KeyPath.Opacity, key: "bgOpacity", additive: false)
    }
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if(anim.valueForKey("out") != nil){
            bg.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    func onTap(){
        println("onTap")
        hiden()
    }
    func onButtonTap(sender:AnyObject){
        var index=(sender as! UIButton).tag
        selectedCallabck!(index: index)
    }
    //重写 UIScrollView 用来判断是否取消所触摸到的view
    override func touchesShouldCancelInContentView(view: UIView!) -> Bool {
        return super.touchesShouldCancelInContentView(view)
    }
    
    
    
    
    
}


