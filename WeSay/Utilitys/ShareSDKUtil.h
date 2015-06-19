//
//  ShareSDKUtil.h
//  WeSay
//
//  Created by qlx on 15/6/13.
//  Copyright (c) 2015年 qlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <RennSDK/RennSDK.h>
@interface ShareSDKUtil : NSObject

+  (void)  initShareSDK;//初始化ShareSDK 社会化组件

+  (void)  share;


@end
