//
//  MQARSCNController+AddNode.swift
//  ARKit_Drawing
//
//  Created by 杨孟强 on 2017/10/25.
//  Copyright © 2017年 杨孟强. All rights reserved.
//

import ARKit

extension MQARSCNController {
    
    //MARK: - touches
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let firstTouch = touches.first else {
            return;
        }
        
        let location = firstTouch.location(in: self.sceneView)
        let pLocation = firstTouch.previousLocation(in: self.sceneView)
        if location.x == pLocation.x && location.y == pLocation.y {
            return
        }
        
        if self.currentNode == nil {
            self.currentNode = MQNode()
            self.addNode(self.currentNode!)
        }
        
        //获取屏幕上当前滑动到点的世界位置
        if let planeHitTestPosition = self.hitTest(location) {
            self.currentNode?.addVertices(vertice: planeHitTestPosition)
        }
    }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    //MARK: - 添加node
    func addNode(_ node: MQNode) {
        self.rootNode.addChildNode(node)
    }
    func addNodes(_ nodes: [MQNode]) {
        if nodes.count > 0 {
            for node in nodes {
                self.rootNode.addChildNode(node)
            }
        }
    }
}
