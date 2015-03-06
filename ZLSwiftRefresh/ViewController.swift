//
//  ViewController.swift
//  ZLSwiftRefresh
//
//  Created by 张磊 on 15-3-6.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UITableViewController {

    // default datas
    var datas:Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 下拉刷新
        self.tableView.toRefreshAction({ () -> () in
            self.delay(2.0, closure: { () -> () in
                println("toRefreshAction success")
                self.datas += 30
                self.tableView.reloadData()
                self.tableView.stopAnimation()
            })
        })
        
        // 上啦加载更多
        self.tableView.toLoadMoreAction({ () -> () in
            self.delay(1.0, closure: { () -> () in
                println("toLoadMoreAction success")
                self.datas += 30
                self.tableView.reloadData()
                self.tableView.stopAnimation()
            });
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        if cell != nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        cell.textLabel.text = "text \(indexPath.row)"
        
        return cell
    }
    
        
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}

