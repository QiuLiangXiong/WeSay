//
//  LoginViewController.swift
//  WeSay
//
//  Created by 邱良雄 on 15/6/13.
//  Copyright (c) 2015年 qlx. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

enum LoginType:Int{
    case  QQ
    case  Sina
    case  WeiXi
    case None
}
class LoginViewController: UIViewController ,UITextFieldDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate{

    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var pwdInput: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var otherLoginButton: UIButton!
    var loginList:ActionSheet?
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化 用户名输入框
        initTextField(nameInput, iconName: "user_name_icon.png")
        //初始化  密码款输入框
        initTextField(pwdInput, iconName: "password_icon.png")
       
        initHeadIcon()
        
        //加入手势 用于取消 键盘
        var tap=UITapGestureRecognizer(target: self, action: "onTap")
        tap.delegate=self
        self.view.addGestureRecognizer(tap)
        //导航栏的背景色
       // self.navigationController?.navigationBar.backgroundColor=UIColor.blueColor()
    
        var title=UILabel(frame: CGRectMake(0, 0, 320, 44))
        title.text="登录"
        title.textAlignment=NSTextAlignment.Center
        title.textColor=UIColor.whiteColor()
        self.navigationItem.titleView=title
        UIApplication.sharedApplication().statusBarStyle=UIStatusBarStyle.LightContent
        
        //设置登录按钮样式
        self.loginButton.setRoundBg(20, color: UIColor.mainColor())
        //设置其他帐号登录样式
        self.otherLoginButton.setRoundBg(20, color: UIColor.mainColor())
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //初始化 输入框
    func initTextField(tf: UITextField , iconName :String){
        //设置输入框的左View
        var icon=UIImageView(name: iconName, contentMode:.Center)
        icon.frame=CGRectMake(0, 0, 43, tf.frame.height)
        tf.leftViewMode=UITextFieldViewMode.Always
        tf.leftView=icon
        
        //设置输入框的背景
        var bg=UIImage(named: "text_field.png")
        bg=bg?.resizableImageWithCapInsets(UIEdgeInsetsMake(10, 44, 10, 10), resizingMode: UIImageResizingMode.Stretch)
        tf.background=bg
        tf.tintColor=UIColor.mainColor()
        tf.delegate=self
        tf.clearButtonMode=UITextFieldViewMode.WhileEditing
        tf.layer.cornerRadius=11
        tf.layer.masksToBounds=true
        tf.keyboardAppearance = UIKeyboardAppearance.Light
    }
    //初始化 头像
    func initHeadIcon(){
        headIcon.layer.cornerRadius=headIcon.frame.width/2
        headIcon.layer.borderWidth=3
        headIcon.layer.masksToBounds=true
        headIcon.layer.borderColor=UIColor.whiteColor().CGColor
    }
    
    // 响应tap手势识别
    @IBAction func tapView(sender: AnyObject) {
        nameInput.resignFirstResponder()
        pwdInput.resignFirstResponder()
    }
    func onTap(){
        tapView(nameInput)
    }
    
    //-------------UITextFieldDelegate   start ----------------------------
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        //println("beginEditing")
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //println(string)
        if   (count(textField.text)>20&&string != ""){
             AudioToolBoxUtil.systemShake()
            return false
           
        }
        
        return true
    }
    
    //-------------UITextFieldDelegate   end ----------------------------

    // 登录 按钮回调用
    @IBAction func onLogin(sender: AnyObject) {
        nameInput.animateWithShake()
        AudioToolBoxUtil.systemShake()
        
    }
    // 使用其他帐号登录回调
    @IBAction func onLoginWithOtherAccount(sender: AnyObject) {
        loginList=ActionSheet()/*
        loginList!.addCellWithImageNameAndText("qq_image.png", text: "QQ登录")
        loginList!.addCellWithImageNameAndText("sina_image.png", text: "微博登录")
//        loginList!.addCellWithText( "")
        loginList!.selectedCallabck=didSelectedWithOtherAccout
        */
        var width=self.view.frame.width
        loginList!.addCellWithButton("QQ登录", width: width)
        loginList!.addCellWithButton("微博登录", width: width)
        loginList!.addCellWithButton("微信登录", width: width)
        
        loginList!.selectedCallabck=didSelectedWithOtherAccout
        loginList!.show(self.view)
    }
    
    // 注册
    @IBAction func onSignUp(sender: AnyObject) {
    }
    
    //忘记密码
    @IBAction func onFindPwd(sender: AnyObject) {
    }
    
    
    
    //------------------------ UIActionSheetDelegate  --------------
    func willPresentActionSheet(actionSheet: UIActionSheet) {
        actionSheet.backgroundColor=UIColor.blueColor()
        actionSheet.subviews
     }
    
    
   ///gestureRecgnize
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if(touch.view != self.view){
            return false
        }
        return true
    }
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //第三方帐号选择登录
    func didSelectedWithOtherAccout(index:Int){
        var type=LoginType(rawValue: index)
        switch type!{
        case LoginType.QQ:
            loginThreePartyAcoountWithType(ShareTypeQQSpace)
        case LoginType.Sina:
            loginThreePartyAcoountWithType(ShareTypeSinaWeibo)
        case LoginType.WeiXi:
            loginThreePartyAcoountWithType(ShareTypeWeixiSession)
        case LoginType.None:
             loginList!.hiden()
        default:
            break;
        }
        
    }
    
    //第三方登录 帐号
    func loginThreePartyAcoountWithType(type:ShareType){
        //ShareSDK.cancelAuthWithType(type)//## 带删除
        ShareSDK.getUserInfoWithType(type, authOptions: nil) { (result, userinfo, error) -> Void in
            if(result){
                var uid=userinfo.uid()
                var nickName=userinfo.nickname()
                var iconURL=userinfo.profileImage()
                self.loginSuccessCallaback(uid, nickName:nickName, iconURL: iconURL)
            }else{
                self.loginList!.hiden()
                println(error.errorDescription())
            }
        }
    }
    
    //登录成功回调
    
    func loginSuccessCallaback(uid:String,nickName:String?,iconURL:String?){
        println("loginSuccess")
    }
    
}
