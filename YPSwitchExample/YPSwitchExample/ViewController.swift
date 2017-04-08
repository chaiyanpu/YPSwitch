//
//  ViewController.swift
//  YPSwitchExample
//
//  Created by chai on 2016/12/23.
//  Copyright © 2016年 chaiyanpu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var ypSwitchOne:YPSwitch?
    private var ypSwitchTwo:YPSwitch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwitchOne()
        addSwitchTwo()
    }
    
    func addSwitchOne(){
        let rect = CGRect(x: 50, y: 50, width: 50, height: 25)
        //TODO:需要添加个初始状态
        let ypSwitchOne = YPSwitch(position: rect.origin,state:.open){
            [unowned self] result in
            result
                .off{
                    self.view.backgroundColor = UIColor.white
                }
                .on{
                    self.view.backgroundColor = UIColor.lightGray
            }
        }
        view.addSubview(ypSwitchOne)
    }
    
    
    
    func addSwitchTwo(){
        ypSwitchTwo = YPSwitch(position:CGPoint(x:50,y:50 + 25 + 10),type: .switchOne)
        guard ypSwitchTwo != nil else {return}

        ypSwitchTwo!.addTarget(self, action: #selector(self.valueChange(_:)), for: UIControlEvents.valueChanged)
        view.addSubview(ypSwitchTwo!)
    }
    
    func valueChange(_ sender:YPSwitch){
        sender.switchState
            .off {
                self.view.backgroundColor = UIColor.white
            }
            .on {
                self.view.backgroundColor = UIColor.lightGray
            }
    }

    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

