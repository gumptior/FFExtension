//
//  Int+.swift
//  Manor
//
//  Created by 杨宝龙 on 2022/11/27.
//  Copyright © 2022 山海数科. All rights reserved.
//

import Foundation

extension Int {
    // 通过时间戳创建Date
    fileprivate var selfDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    
    public var toTimeStr: String {
        get {
            let timeInterval = selfDate.timeIntervalSinceNow
            let seconds = UInt(fabs(round(timeInterval)))
//            let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
            let toDayStartDate = Calendar.current.startOfDay(for: Date())
            
            let dateComponent = Calendar.current.dateComponents([.day], from: selfDate, to: toDayStartDate)
            
            
            
            
            
//            let isToday = selfDate.isToday
//            let isYesterday = selfDate.isYesterday
//            let isTheDayBeforeYesterday = selfDate.isTheDayBeforeYesterday
//
//            let diff:DateComponents = calendar.dateComponents([.day], from: startDate!, to: endDate!)
//              return diff.day!
            
            if selfDate.isToday {
                if seconds < 60 {
                    return "1分钟前"
                } else if seconds < 3600 {
                    return "\(seconds/60)分钟前"
                } else {
                    return "\(seconds/(3600))小时前"
                }
            } else if selfDate.isYesterday {
                return "昨天"
            } else if selfDate.isTheDayBeforeYesterday {
                return "前天"
            } else if dateComponent.day! < 7 {
//                if dateComponent.day == 2 {
//                    print(toDayStartDate.timeIntervalSince1970)
//                }
                return "\(dateComponent.day! + 1)天前"
            } else if selfDate.isThisYear {
                return selfDate.toformatterTimeString(formatter: "MM月dd日")
            } else {
                return selfDate.toformatterTimeString(formatter: "yyyy年MM月dd日")
            }
//            
//            
//            
//            var timeStr = ""
//            if seconds < 60 {
////                return "刚刚"
//                timeStr = "1分钟前"
//            } else if seconds < 3600 {
//                timeStr = "\(seconds/60)分钟前"
//            } else if dateComponent.day == 1 {
//                timeStr = "昨天"
////            } else if selfDate.isYesterday {
////                return "昨天"
//            } else if dateComponent.day == 2 {
//                timeStr = "前天"
//            } else if seconds < 3600*24 {
//                timeStr = "\(seconds/(3600))小时前"
//            } else if dateComponent.day! < 8 {
//                timeStr = "\(dateComponent.day!)天前"
//            } else if selfDate.isThisYear {
//                timeStr =
//            }else{
//                timeStr =
//            }
//            
////            print("当前时间戳：\(self),转换结果：\(timeStr))
//            
//            return timeStr
            
//            let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
//            let dateComponent = Calendar.current.dateComponents(components, from: selfDate, to: Date())
//            if !selfDate.isThisYear {
//                return selfDate.toformatterTimeString(formatter: "yyyy年MM月dd日")
//            }
//            if dateComponent.day! >= 7 {
//                return selfDate.toformatterTimeString(formatter: "MM月dd日")
//            } else if dateComponent.day! >= 3 {
//                return "\(dateComponent.day!)天前"
//            } else if dateComponent.day! == 2 {
//                return "前天"
//            } else if dateComponent.day! == 1 {
//                return "昨天"
//            } else if dateComponent.hour! >= 1 {
//                return "\(dateComponent.hour!)小时前"
//            } else if dateComponent.minute! >= 1 {
//                return "\(dateComponent.minute!)分钟前"
//            } else if dateComponent.second! < 60 {
//                return "刚刚"
//            } else {
//                return "时间错误"
//            }
        }
    }
    
//    func toTimeStr(dateFormat: String) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = dateFormat
//        let timeStr = formatter.string(from: selfDate)
//
//        return timeStr
//    }
}

public extension Date {
    // MARK: 2.3、Date 转换为相应格式的时间字符串，如 Date 转为 2020-10-28
    /// Date 转换为相应格式的字符串，如 Date 转为 2020-10-28
    /// - Parameter format: 转换的格式
    /// - Returns: 返回具体的字符串
    func toformatterTimeString(formatter: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }
}

// MARK:- 三、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断
public extension Date {
    // MARK: 3.1、今天的日期
    /// 今天的日期
    var todayDate: Date {
        return Date()
    }
//    // MARK: 3.2、昨天的日期
//    /// 昨天的日期
//    var yesterDayDate: Date? {
//        return adding(day: -1)
//    }
//    // MARK: 3.3、明天的日期
//    /// 明天的日期
//    var tomorrowDate: Date? {
//        return adding(day: 1)
//    }
//    // MARK: 3.4、前天的日期
//    /// 前天的日期
//    var theDayBeforYesterDayDate: Date? {
//        return adding(day: -2)
//    }
//    // MARK: 3.5、后天的日期
//    /// 后天的日期
//    var theDayAfterYesterDayDate: Date? {
//        return adding(day: 2)
//    }
//    // MARK: 3.6、是否为今天（只比较日期，不比较时分秒）
//    /// 是否为今天（只比较日期，不比较时分秒）
//    /// - Returns: bool
//    var isToday: Bool {
//        let date = Date()
//        if self.toformatterTimeString(formatter: "yyyyMMdd") == date.toformatterTimeString(formatter: "yyyyMMdd") {
//            return true
//        }
//        return false
//    }
//    // MARK: 3.7、是否为昨天
//    /// 是否为昨天
//    var isYesterday: Bool {
//        // 1.先拿到昨天的 date
//        guard let date = Date().yesterDayDate else {
//            return false
//        }
//        // 2.比较当前的日期和昨天的日期
//        return isSameYeaerMountDay(date)
//    }

    
    /// 是否为今年
    var isThisYear: Bool  {
        let calendar = Calendar.current
        let nowCmps = calendar.dateComponents([.year], from: Date())
        let selfCmps = calendar.dateComponents([.year], from: self)
        let result = nowCmps.year == selfCmps.year
        return result
    }
    
    /// 是否为  同一年  同一月 同一天
    var isToday: Bool {
        return isSameYeaerMountDay(Date())
    }
    
    /// 是否为昨天
    var isYesterday: Bool {
        // 1.先拿到昨天的 date
        let date = Date().adding(day: -1)!
        
        // 2.比较当前的日期和昨天的日期
        return isSameYeaerMountDay(date)
    }
    
    /// 是否为前天
    var isTheDayBeforeYesterday: Bool  {
        // 1.先拿到前天的 date
        let date = Date().adding(day: -2)!
            
        // 2.比较当前的日期和昨天的日期
        return isSameYeaerMountDay(date)
    }
    
    /// 日期的加减操作
    /// - Parameter day: 天数变化
    /// - Returns: date
    private func adding(day: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day:day), to: self)
    }
    /// 是否为  同一年  同一月 同一天
    /// - Parameter date: date
    /// - Returns: 返回bool
    private func isSameYeaerMountDay(_ date: Date) -> Bool {
        let com = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let comToday = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return (com.day == comToday.day &&
            com.month == comToday.month &&
        com.year == comToday.year )
    }
}
