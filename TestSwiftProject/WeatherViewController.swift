//
//  WeatherViewController.swift
//  TestSwiftProject
//
//  Created by 舒永超 on 16/6/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

import UIKit

import SwiftyJSON
import SnapKit

class WeatherViewController: UIViewController {

    let apiKey = "17e5b9ec5931e61b70371c424f94bcdb"

    var bottomConstraint:Constraint?
    var label = UILabel()
    var toolBar = UIView()
    var sendBtn = UIButton(type: .System)
    var textField = UITextField()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "天气情况"

        label.frame = CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, 0)
        label.textColor = UIColor.greenColor()
        label.numberOfLines = 0
        self.view.addSubview(label)

        toolBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.view.addSubview(toolBar)

        toolBar.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(50)
            self.bottomConstraint = make.bottom.equalTo(self.view).constraint
        }

        sendBtn.setTitle("查询", forState: .Normal)
        sendBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sendBtn.backgroundColor = UIColor.orangeColor()
        sendBtn.addTarget(self, action: #selector(sendMessage(_:)), forControlEvents: .TouchUpInside)
        toolBar.addSubview(sendBtn)

        sendBtn.snp_makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.centerY.equalTo(toolBar)
            make.right.equalTo(toolBar).offset(-10)
        }

        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.placeholder = "请输入城市名字"
        toolBar.addSubview(textField)

        textField.snp_makeConstraints { (make) in
            make.left.equalTo(toolBar).offset(10)
            make.right.equalTo(sendBtn.snp_left).offset(-10)
            make.height.equalTo(30)
            make.centerY.equalTo(toolBar)
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WeatherViewController.keyboardWillChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    func sendMessage(button:UIButton) {
        textField.resignFirstResponder()
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            self.getWeatherData()
        }
    }

    func keyboardWillChange(notification:NSNotification) {
        if let userInfo = notification.userInfo,
            value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {

            let frame = value.CGRectValue()
            let intersection = CGRectIntersection(frame, self.view.frame)
            self.bottomConstraint?.updateOffset(-CGRectGetHeight(intersection))

            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: curve), animations: { 
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     获取天所数据
     */
    func getWeatherData() {

        var city:String = textField.text!

        if city.isEmpty {
            city = "beijing"
        }

        let apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(apiKey)"

        let url = NSURL(string: apiUrl)!

        guard let weatherData = NSData(contentsOfURL: url) else {return}

        let str = String(data: weatherData, encoding: NSUTF8StringEncoding)!

        print(JSON.parse(str))

        dispatch_sync(dispatch_get_main_queue()) {

            self.label.text = str
            self.label.sizeToFit()
        }
    }
}
