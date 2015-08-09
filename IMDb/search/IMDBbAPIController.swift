//
//  IMDBbAPIController.swift
//  IMDb
//
//  Created by toxufe on 15/8/9.
//  Copyright (c) 2015年 toxufe. All rights reserved.
//

import UIKit


protocol IMDbAPIControllerDelegate{
    func didFinishIMDbSearch(resule:Dictionary<String,String>)
}
class IMDBbAPIController: NSObject {
    var delegate:IMDbAPIControllerDelegate?
    
    init(delegate:IMDbAPIControllerDelegate){
        self.delegate = delegate
    }
    
    func searchIMDb(forContent:String){
        //将字符串转换成一个合法的URL字符串
        var spacelessString = forContent.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        //println(spacelessString)
        
        //创建了一个NSURL类型的对象
        var urlPath = NSURL(string: "http://www.omdbapi.com/?t=\(spacelessString!)")
        
        //获取NSURLSession对象
        var session = NSURLSession.sharedSession()
        //创建get请求
        var task = session.dataTaskWithURL(urlPath!, completionHandler: { (data,response, error) -> Void in
            if error != nil {
                println(error.localizedDescription)
            }
            
            var jsonError:NSError?
            
            //格式化JSON数据
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as! Dictionary<String,String>
            
            if jsonError != nil {
                println(jsonError?.localizedDescription)
            }
            
            //异步主线程 ui更改必须在主线程中执行
            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.titleLabel.text = jsonResult["Title"]
//                self.releasedLabel.text = jsonResult["Released"]
//                self.ratingLabel.text = jsonResult["Rated"]
//                self.plotLabel.text = jsonResult["Plot"]
//            })
            
            if let apiDelegate = self.delegate {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    apiDelegate.didFinishIMDbSearch(jsonResult)
                })
            }
            
        })
        
        task.resume()
        
        
        
        
        
    }
   
}
