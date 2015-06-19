//
//  AudioToolBoxUtil.swift
//  WeSay
//
//  Created by qlx on 15/6/16.
//  Copyright (c) 2015年 qlx. All rights reserved.
//

import UIKit
class AudioToolBoxUtil: NSObject {
    class func systemShake(){
        var sound:SystemSoundID = SystemSoundID(kSystemSoundID_Vibrate)
        AudioServicesPlayAlertSound(sound);
    }
}
