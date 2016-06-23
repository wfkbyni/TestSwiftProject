//
//  DateFormatController.swift
//  TestSwiftProject
//
//  Created by 舒永超 on 16/6/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

import UIKit

class DateFormatController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        self.title = "日期转换"

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"

        let startDate = startOfCurrentMonth()
        print("本月开始第一天日期: ", dateFormatter.stringFromDate(startDate))

        let endDate = endOfCurrentMonth()
        print("本月结束最后一天日期1: ", dateFormatter.stringFromDate(endDate))

        let endDate2 = endOfCurrentMonth(true)
        print("本月结束最后一天日期2: ", dateFormatter.stringFromDate(endDate2))

        //当月第一天日期
        let startDate2 = startOfMonth(2016, month: 8)
        print("2016年8月的开始时间：", dateFormatter.stringFromDate(startDate2))

        //当月最后一天日期1
        let endDate1 = endOfMonth(2016, month: 8)
        print("2016年8月的结束时间1：", dateFormatter.stringFromDate(endDate1))

        //当月最后一天日期2
        let endDate22 = endOfMonth(2016, month: 8, returnEndTime:true)
        print("2016年8月的结束时间2：", dateFormatter.stringFromDate(endDate22))

        let days = getDaysInCurrentMonth(2015, month: 8)
        print("转换时间为：", days)
    }

    // 本月开始日期
    func startOfCurrentMonth() -> NSDate {

        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month], fromDate: date)
        let startOfMonth = calendar.dateFromComponents(components)!

        return startOfMonth
    }

    // 本月结束日期
    func endOfCurrentMonth(returnEndTime:Bool = false) -> NSDate {

        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.month = 1

        if returnEndTime {
            components.second = -1
        }else{
            components.day = -1
        }

        let endOfMonth = calendar.dateByAddingComponents(components, toDate: startOfCurrentMonth(), options: [])!

        return endOfMonth
    }

    // 指定年 月的第一天
    func startOfMonth(year:Int, month:Int) -> NSDate {

        let calandar = NSCalendar.currentCalendar()
        let startComponents = NSDateComponents()
        startComponents.day = 1
        startComponents.month = month
        startComponents.year = year

        let startDate = calandar.dateFromComponents(startComponents)

        return startDate!

    }

    // 指定年 月的最后一天
    func endOfMonth(year:Int, month:Int, returnEndTime:Bool = false) -> NSDate {

        let calandar = NSCalendar.currentCalendar()
        let endComponents = NSDateComponents()
        endComponents.month = 1
        if returnEndTime {
            endComponents.second = -1
        }else{
            endComponents.day = -1
        }

        let endOfYear = calandar.dateByAddingComponents(endComponents, toDate: startOfMonth(year, month: month), options: [])!

        return endOfYear

    }

    // 计算当月的天数
    func getDaysInCurrentMonth(year:Int = 2016, month:Int = 6) -> Int {
        let calandar = NSCalendar.currentCalendar()

        let startComponents = NSDateComponents()
        startComponents.day = 1
        startComponents.month = month
        startComponents.year = year

        let endComponents = NSDateComponents()
        endComponents.day = 1
        endComponents.month = month == 12 ? 1 : month + 1
        endComponents.year = year == 12 ? year + 1 : year

        let startDate = calandar.dateFromComponents(startComponents)!
        let endDate = calandar.dateFromComponents(endComponents)!

        let diff = calandar.components(.Day, fromDate: startDate, toDate: endDate, options: .MatchFirst)

        return diff.day
    }

}
