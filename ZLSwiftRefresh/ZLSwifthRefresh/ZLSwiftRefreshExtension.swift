//
//  ZLSwiftRefreshExtension.swift
//  ZLSwiftRefresh
//
//  Created by 张磊 on 15-3-6.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

import UIKit

enum RefreshStatus{
    case Normal, Refresh, LoadMore
}

let contentOffsetKeyPath = "contentOffset"
var addObserverNum:NSInteger = 0;
var headerView:ZLSwiftHeadView = ZLSwiftHeadView(frame: CGRectZero)
var footView:ZLSwiftFootView = ZLSwiftFootView(frame: CGRectZero)

/** refresh && loadMore callBack */
var refreshAction: (() -> ()) = {}
var loadMoreAction: (() -> ()) = {}
var refreshTempAction:(() -> ()) = {}
var loadMoreTempAction:(() -> ()) = {}
var refreshStatus:RefreshStatus = .Normal
var loading:Bool = false

extension UIScrollView: UIScrollViewDelegate {
    
    //MARK: Refresh
    func toRefreshAction(action :(() -> ())){
        self.addObserver()
        self.addHeadView()
        refreshAction = action
    }
    
    //MARK: LoadMore
    func toLoadMoreAction(action :(() -> ())){
        self.addObserver()
        self.addFootView()
        loadMoreAction = action
    }
    
    //MARK: AddHeadView && FootView
    func addHeadView(){
        var headView:ZLSwiftHeadView = ZLSwiftHeadView(frame: CGRectMake(0, -ZLSwithRefreshHeadViewHeight, self.frame.size.width, ZLSwithRefreshHeadViewHeight))
        headView.backgroundColor = UIColor.redColor()
        self.addSubview(headView)
        headerView = headView
    }
    
    func addFootView(){
        footView = ZLSwiftFootView(frame: CGRectMake(0, -ZLSwithRefreshFootViewHeight, self.frame.size.width, ZLSwithRefreshHeadViewHeight))
        footView.backgroundColor = UIColor.redColor()
        
        let tempTableView :UITableView = self as UITableView
        tempTableView.tableFooterView = footView
        tempTableView.contentInset = UIEdgeInsetsMake(0, 0, -ZLSwithRefreshFootViewHeight, 0)
    }
    
    //MARK: Observer KVO Method
    func addObserver(){
        
        if(addObserverNum == 0){
            self.addObserver(self, forKeyPath: contentOffsetKeyPath, options: .Initial, context: nil)
        }
        
        addObserverNum+=1
    }
    
    func removeObserver(){
        self.removeObserver(self, forKeyPath: contentOffsetKeyPath)
    }
    
    public override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {

        var scrollView = self
        let tempTableView :UITableView = self as UITableView
        var scrollViewContentOffsetY = scrollView.contentOffset.y

        
        // 下拉刷新
        if (scrollViewContentOffsetY < -ZLSwithRefreshHeadViewHeight * 0.5) {
            // 提示 -》松开刷新
            if scrollView.dragging == false && loading == false{
                if refreshTempAction != nil {
                    loading = true
                    refreshTempAction()
                    refreshTempAction = {}
                    loading = false
                }
            }
            
            headerView.title = ZLSwithRefreshMessageText
        }else{
            refreshTempAction = refreshAction
            headerView.title = ZLSwithRefreshHeadViewText
        }
        
        if tempTableView.tableFooterView != nil && scrollViewContentOffsetY > 0{
            // 上啦加载更多
            var nowContentOffsetY:CGFloat = scrollView.contentOffset.y + self.frame.size.height
            var tableViewMaxHeight:CGFloat = CGRectGetMidY(tempTableView.tableFooterView!.frame)
            if (nowContentOffsetY - tableViewMaxHeight) > ZLSwithRefreshFootViewHeight * 0.5{
                if scrollView.dragging == false && loading == false{
                    if loadMoreTempAction != nil {
                        loading = true
                        loadMoreTempAction()
                        loadMoreTempAction = {}
                        loading = false
                    }
                }
                
                footView.title = ZLSwithRefreshMessageText
            }else{
                loadMoreTempAction = loadMoreAction
                footView.title = ZLSwithRefreshFootViewText
            }
        }
    }
    
}
