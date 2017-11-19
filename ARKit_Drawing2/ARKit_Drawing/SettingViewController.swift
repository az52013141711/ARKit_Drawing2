//
//  SettingViewController.swift
//  ARKit_Drawing
//
//  Created by 杨孟强 on 2017/11/18.
//  Copyright © 2017年 杨孟强. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var linecolorControl: UISegmentedControl!
    @IBOutlet weak var linewidthControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //0随机 1橙色 2蓝色 3红色 4白色 5黑色
        var select:Int!
        switch MQARSCNController.sharedInstance.linecolour {
        case UIColor.orange?:
            select = 1
        case UIColor.blue?:
            select = 2
        case UIColor.red?:
            select = 3
        case UIColor.white?:
            select = 4
        case UIColor.black?:
            select = 5
        default:
            select = 0
        }
        linecolorControl.selectedSegmentIndex = select
        
        linewidthControl.selectedSegmentIndex = Int(MQARSCNController.sharedInstance.linewidth * 1000 - 1)
    }
    
    @IBAction func colorValueChanged(_ sender: UISegmentedControl) {
        //0随机 1橙色 2蓝色 3红色 4白色 5黑色
        var color:UIColor?
        switch sender.selectedSegmentIndex {
        case 1:
            color = UIColor.orange
        case 2:
            color = UIColor.blue
        case 3:
            color = UIColor.red
        case 4:
            color = UIColor.white
        case 5:
            color = UIColor.black
        default:
            color = nil
        }
        MQARSCNController.sharedInstance.linecolour = color
    }
    

    @IBAction func widthValueChanged(_ sender: UISegmentedControl) {
         MQARSCNController.sharedInstance.linewidth = Double(sender.selectedSegmentIndex + 1) / 1000
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
