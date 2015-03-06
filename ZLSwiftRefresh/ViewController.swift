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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 下拉刷新
        self.tableView.toRefreshAction({ () -> () in
            println("toRefreshAction success")
        })
        
        // 上啦加载更多
        self.tableView.toLoadMoreAction({ () -> () in
            println("toLoadMoreAction success")
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        if cell != nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        cell.textLabel.text = "text \(indexPath.row)"
        
        return cell
    }
    

    
}

