//
//  UIFont+.swift
//  Manor
//
//  Created by 杨宝龙 on 2022/11/11.
//  Copyright © 2022 山海数科. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func mediumFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: fontSize)!
    }
    
    static func custom(ofSize size: CGFloat) -> UIFont {
        return UIFont.init(name: "PangMenZhengDao", size: size)!
    }
    
    static func BoldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Bold", size: fontSize)!
    }
    
    static func semiBoldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Semibold", size: fontSize)!
    }
}
