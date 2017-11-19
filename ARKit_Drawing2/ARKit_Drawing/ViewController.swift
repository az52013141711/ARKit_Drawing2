//
//  ViewController.swift
//  ARKit_Drawing
//
//  Created by 杨孟强 on 2017/9/10.
//  Copyright © 2017年 杨孟强. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    let sceneView = MQARSCNController.sharedInstance.sceneView
    
    //启动session
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(ARWorldTrackingConfiguration())//启动
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()//暂停
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.frame = self.view.bounds
        self.view.addSubview(sceneView)
        self.view.sendSubview(toBack: sceneView)
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "撤销", style: .done, target: self, action: #selector(clickRevoke))
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "设置", style: .done, target: self, action: #selector(clickSetting)),
            UIBarButtonItem(title: "清屏", style: .done, target: self, action: #selector(clickClearTheScreen))
        ]
    }
    
    // MARK: - Gesture Recognizers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        MQARSCNController.sharedInstance.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        MQARSCNController.sharedInstance.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        MQARSCNController.sharedInstance.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        MQARSCNController.sharedInstance.touchesCancelled(touches, with: event)
    }
    
    
    //点击设置
    @objc func clickSetting() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    //点击清屏
    @objc func clickClearTheScreen() {
        MQARSCNController.sharedInstance.clearTheScreen()
    }
    //点击撤销
    @objc func clickRevoke() {
        MQARSCNController.sharedInstance.revoke()
    }
    
    // MARK: -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
