//
//  ViewController.swift
//  TestSwiftProject
//
//  Created by 舒永超 on 16/6/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var label:UILabel!
    var myTableView:UITableView!
    var button:UIButton!

    var arrayRows = Array(arrayLiteral: "日期转换")
    var ArrayControllers = Array(arrayLiteral: DateFormatController())

    var screenBounds = UIScreen.mainScreen().bounds;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "测试Swift"

        label = UILabel(frame: CGRectMake(0,84,screenBounds.size.width,21))
        label.text = "这是一个label"
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)

        myTableView = UITableView(frame: CGRectMake(0, 110, screenBounds.size.width, screenBounds.size.height - CGRectGetMaxY(label.frame) - 80), style: UITableViewStyle.Plain)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)

        button = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(20, CGRectGetMaxY(myTableView.frame) + 14, screenBounds.width - 40, 50)
        button.setTitle("查询天气情况", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Highlighted)
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: #selector(btnOnCliceEvent(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(button)

        let moveView = UIView(frame: CGRectMake( 0, 0, 80, 80))
        moveView.center = self.view.center
        moveView.backgroundColor = UIColor.redColor()
        self.view.addSubview(moveView)

        UIView.animateWithDuration(3, animations: {
            moveView.frame = CGRectMake(0, 0, 120, 120)
            moveView.center = self.view.center
            moveView.backgroundColor = UIColor.greenColor()

            }) { (true) in
        }

    }


    func btnOnCliceEvent(button:UIButton) {
        self.navigationController?.pushViewController(WeatherViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRows.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)

        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }

        cell?.textLabel?.text = arrayRows[indexPath.row]

        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        self.navigationController?.pushViewController(ArrayControllers[indexPath.row], animated: true)
    }


}

