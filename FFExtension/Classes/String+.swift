//
//  String+.swift
//  Manor
//
//  Created by 杨宝龙 on 2022/11/14.
//  Copyright © 2022 山海数科. All rights reserved.
//

import Foundation

extension String {

    func substring(from: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        return String(self[start..<endIndex])
    }

    func substring(to: Int) -> String {
        if self == "" {
            return ""
        }
        let end = index(startIndex, offsetBy: to)
        return String(self[startIndex..<end])
    }

}

extension String? {
    var isEmpty: Bool {
        if self == nil {
            return true
        } else if self == "" {
            return true
        }
        return false
    }
}

extension String {
    // 计算文字所占屏幕大小
    func size(font: UIFont, maxSize: CGSize) -> CGSize {
        if self == "" {
            return .zero
        }
        let attrs = [NSAttributedString.Key.font: font]
        return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }
}

extension String {
   public var containEmoji: Bool {
       // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
       for scalar in unicodeScalars {
           switch scalar.value {
           case 0x3030, 0x00AE, 0x00A9, // Special Characters
           0x1D000...0x1F77F, // Emoticons
           0x2100...0x27BF, // Misc symbols and Dingbats
           0xFE00...0xFE0F, // Variation Selectors
           0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
               return true
           default:
               continue
           }
       }
       return false
   }
}
