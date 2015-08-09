//
//  ViewController.swift
//  IMDb
//
//  Created by toxufe on 15/8/9.
//  Copyright (c) 2015年 toxufe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    
    @IBAction func buttonPressed(sender: UIButton) {
        self.posterImageView.image = UIImage(named: "lion")
        self.searchIMDb("The Lion King")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.titleLabel.text = jsonResult["Title"]
                self.releasedLabel.text = jsonResult["Released"]
                self.ratingLabel.text = jsonResult["Rated"]
                self.plotLabel.text = jsonResult["Plot"]
            })

        })
        
        task.resume()
        
        
        
        
        
    }
    
    


}

