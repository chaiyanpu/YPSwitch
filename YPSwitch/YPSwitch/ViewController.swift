//
//  ViewController.swift
//  YPSwitch
//
//  Created by chai on 2016/12/8.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 50, y: 50, width: 50, height: 25)
        let ypSwitch = YPSwitch(frame:rect,type:.switchTwo(rect))
        
        view.addSubview(ypSwitch)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

