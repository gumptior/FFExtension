//
//  FF_Universal.swift
//  Manor
//
//  Created by 杨宝龙 on 2022/11/14.
//  Copyright © 2022 山海数科. All rights reserved.
//

import UIKit

/// 状态栏高度
public var _kStatusBarHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.height
    
}

/// 导航栏高度
public var _kNavigationHeight: CGFloat {
    return 49 + _kStatusBarHeight
}

/// 底部安全高度
public var _kBottomSafeAreaHeight: CGFloat {
    return (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!
}

/// 是否是刘海屏
public var _kIsBangsScreen: Bool {
    return _kStatusBarHeight == 44
}

/// 是否是开发环境
public var isDevEnvironment_FF_Swift: Bool {
    #if APPDIS
    return false
    #else
    return true
    #endif
}

public var AD_SLOT_EXPRESS_FF_Switf: String {
    return isDevEnvironment_FF_Swift ? "950210374" : "950267645" // Feed流 广告
}

public var AD_SLOT_BANNER_FF_Switf: String {
    return isDevEnvironment_FF_Swift ? "950210378" : "950271284" // Banner 广告
}

public var AD_SLOT_EXPRESSVIEWHEIGHT_FF_Switf: CGFloat {
    return 280
}



extension NSNotification.Name {
    
    public static let FF_DynamicRelease = NSNotification.Name(rawValue: "FF_DynamicRelease")
    
    public static let FF_Logout = NSNotification.Name(rawValue: "FF_Logout")
    
    public static let FF_Login = NSNotification.Name(rawValue: "LHLoginScuessKey")
}
