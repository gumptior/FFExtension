//
//  UIView+.swift
//  Manor
//
//  Created by 杨宝龙 on 2022/11/14.
//  Copyright © 2022 山海数科. All rights reserved.
//

import UIKit

extension UIView {
    /// 当前的视图对应的视图控制器  （为了避免与其他类库冲突故使用缩写）
    var VC: UIViewController? {
        for view in sequence(first: self, next: {$0?.superview}) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    /// 当前的视图对应的导航控制器
    var navigationController: UINavigationController? {
        return VC?.navigationController
    }
}
