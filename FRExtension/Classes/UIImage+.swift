//
//  UIImage+.swift
//  Manor
//
//  Created by 杨宝龙 on 2022/11/11.
//  Copyright © 2022 山海数科. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 渐变方向
    enum GradientDirection {
        case horizontal // 水平从左到右
        case vertical // 垂直从上到下
        case leftOblique // 左上到右下
        case rightOblique // 右上到左下
        case other(CGPoint, CGPoint)
    
        public func point(size: CGSize) -> (CGPoint, CGPoint) {
            switch self {
            case .horizontal:
                return (CGPoint.init(x: 0, y: 0), CGPoint.init(x: size.width, y: 0))
            case .vertical:
                return (CGPoint.init(x: 0, y: 0), CGPoint.init(x: 0, y: size.height))
            case .leftOblique:
                return (CGPoint.init(x: 0, y: 0), CGPoint.init(x: size.width, y: size.height))
            case .rightOblique:
                return (CGPoint.init(x: size.width, y: 0), CGPoint.init(x: 0, y: size.height))
            case .other(let stat, let end):
                return (stat, end)
            }
        }
    }
    
    // MARK: 生成渐变色的图片
    /// - Parameters:
    ///   - colors: UIColor 数组
    ///   - size: 图片大小
    ///   - locations: locations 数组
    ///   - direction: 渐变的方向
    /// - Returns: 渐变的图片
    static func gradient(_ colors: [UIColor], size: CGSize = CGSize(width: 10, height: 10), locations:[CGFloat]? = nil, direction: GradientDirection = .horizontal) -> UIImage? {
        return gradient(colors, size: size, radius: 0, locations: locations, direction: direction)
    }
    
    // MARK: 生成渐变色的图片 - 带圆角
    /// - Parameters:
    ///   - colors: UIColor 数组
    ///   - size: 图片大小
    ///   - radius: 圆角
    ///   - locations: locations 数组
    ///   - direction: 渐变的方向
    /// - Returns: 带圆角的渐变的图片
    static func gradient(_ colors: [UIColor],
                         size: CGSize = CGSize(width: 10, height: 10),
                         radius: CGFloat = 0,
                         locations:[CGFloat]? = nil,
                         direction: GradientDirection = .horizontal) -> UIImage? {
        if colors.count == 0 { return nil }
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius)
        path.addClip()
        context?.addPath(path.cgPath)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map{$0.cgColor} as CFArray, locations: locations?.map { CGFloat($0) }) else { return nil
        }
        let directionPoint = direction.point(size: size)
        context?.drawLinearGradient(gradient, start: directionPoint.0, end: directionPoint.1, options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}

// 通过颜色生成图片
extension UIImage {
    
    convenience init?(color: UIColor, alpha: CGFloat = 1.0) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setAlpha(alpha)
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImg = img?.cgImage else { self.init(); return nil }
        self.init(cgImage: cgImg)
    }
    
}

extension UIImage {
    func compressOriginalImage(to maxDataSizeKBytes: CGFloat) -> Data? {
        var data = self.jpegData(compressionQuality: 1.0)
        var dataKBytes: CGFloat = Double((data?.count ?? 0)) / 1000.0
        var maxQuality: CGFloat = 0.9
        var lastData: CGFloat = dataKBytes
        while dataKBytes > maxDataSizeKBytes && maxQuality > 0.01 {
            maxQuality = maxQuality - 0.01
            data = self.jpegData(compressionQuality: maxQuality)
            dataKBytes = Double((data?.count ?? 0)) / 1000.0
            if lastData == dataKBytes {
                break
            } else {
                lastData = dataKBytes
            }
        }
        return data
    }
}

extension UIImage {
    //二分压缩法
    func compressImageMid(maxLength: Int) -> UIImage? {
        var compression: CGFloat = 1
        guard var data = self.jpegData(compressionQuality: 1) else { return nil }
        print("压缩前kb: \( Double((data.count)/1024))")
        if data.count < maxLength {
            return self
        }
        print("压缩前kb", data.count / 1024, "KB")
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = self.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
//        var resultImage: UIImage = UIImage(data: data)!
//        if data.count < maxLength {
//            return data
//        }else{
//            return nil
//        }
        print("压缩后kb", data.count / 1024, "KB")
        return UIImage(data: data)!
    }
}
