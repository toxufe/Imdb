//
//  ViewController.swift
//  IMDb
//
//  Created by toxufe on 15/8/9.
//  Copyright (c) 2015年 toxufe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,IMDbAPIControllerDelegate {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    //声明apiController变量的时候，我们将它初始化，并且需要当前的控制器对象作为参数，此时当前的控制器对象还没有构造完成。因为有了lazy属性，apiController只有在第一次被访问的时候才会创建。
    
    //声明使用延迟储存属性，当第一次被调用的时候，才会计算其初始值的属性。
    lazy var apiController:IMDBbAPIController = IMDBbAPIController(delegate: self)
    func didFinishIMDbSearch(resule: Dictionary<String, String>) {
        self.titleLabel.text = resule["Title"]
        self.releasedLabel.text = resule["Released"]
        self.ratingLabel.text = resule["Rated"]
        self.plotLabel.text = resule["Plot"]
        
        if let foundPosterUrl = resule["Poster"]{
            self.formatImageFromPath(foundPosterUrl)
        }
    }
    
    
    //返回图片Poster
    func formatImageFromPath(path:String){
        var posterUrl = NSURL(string: path)
        var posterImageData = NSData(contentsOfURL: posterUrl!)
        self.posterImageView.image = UIImage(data: posterImageData!)
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        //self.posterImageView.image = UIImage(named: "lion")
        self.apiController.searchIMDb("The Lion King")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        apiController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    


}

