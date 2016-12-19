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
        
        addSwitchOne()
        addSwitchTwo()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addSwitchOne(){
        let rect = CGRect(x: 50, y: 50, width: 50, height: 25)
        let ypSwitch = YPSwitch(position: rect.origin, type: .switchOne){
            [unowned self] result in
            result
                .off{ value in
                    print(value)
                    self.view.backgroundColor = UIColor.white
                }
                .on{ value in
                    print(value)
                    self.view.backgroundColor = UIColor.lightGray
            }
        }
        view.addSubview(ypSwitch)
    }
    
    func addSwitchTwo(){
        let ypSwitchTwo = YPSwitch(position:CGPoint(x:50,y:200), type: .switchOne)
        
        ypSwitchTwo.addTarget(self, action: #selector(self.valueChange(_:)), for: UIControlEvents.valueChanged)
        view.addSubview(ypSwitchTwo)
    }
    
    func valueChange(_ sender:YPSwitch){
        switch sender.switchState{
        case let .open(value):
    
            print(value)
            self.view.backgroundColor = UIColor.lightGray
        case let .close(value):
            
            print(value)
            self.view.backgroundColor = UIColor.white
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

