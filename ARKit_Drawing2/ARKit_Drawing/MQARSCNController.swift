//
//  MQScene.swift
//  ARKit_Drawing
//
//  Created by 杨孟强 on 2017/10/24.
//  Copyright © 2017年 杨孟强. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

/// 禁止使用init方法初始化,请使用共享实例MQARSCNController.sharedInstance
class MQARSCNController {
    
    //MARK: - 属性
    var currentNode:MQNode?//当前绘制的node,每次按下屏幕->移动手指->松手手指创建一个node
    let sceneView:ARSCNView = {
        let view = ARSCNView()
        view.scene = SCNScene()
        return view
    }()
    private var rootNodeVaule:SCNNode? = nil
    var rootNode:SCNNode! {
        get {
            if rootNodeVaule == nil {
                rootNodeVaule = SCNNode()
                sceneView.scene.rootNode.addChildNode(rootNodeVaule!)
            }
            return rootNodeVaule
        }
        set {
            rootNodeVaule = newValue
        }
    }
    
    private var linecolourValue:UIColor? = nil
    var linecolour:UIColor? {
        get {
            if linecolourValue == nil {
                return UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
            } else {
                return linecolourValue
            }
        }
        set {
            linecolourValue = newValue
        }
    }
    var linewidth:Double! = 0.001
    
    
    //MARK: - 初始化
    /// 共享实例
    static var sharedInstance:MQARSCNController = {
        let instance = MQARSCNController();
        return instance;
    }()
    private init() {
        
    }
    
    
    //MARK: - 清屏
    func clearTheScreen() {
        self.rootNode.removeFromParentNode()
        self.rootNode = nil
    }
    
    //MARK: - 撤销
    func revoke() {
        
        guard let lastNode = self.rootNode.childNodes.last else {
            return
        }
        lastNode.removeFromParentNode()
    }
 
}
