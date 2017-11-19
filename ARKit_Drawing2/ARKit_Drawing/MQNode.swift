//
//  MQShapeNode.swift
//  ARKit_Drawing
//
//  Created by 杨孟强 on 2017/9/10.
//  Copyright © 2017年 杨孟强. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class MQNode: SCNNode {
    
    var sceneView:ARSCNView?
    
    private var lineVertices:[SCNVector3] = []//线条信息
    private var roundPreviousVertices:[SCNVector3] = []
    
    //MARK: 添加一个笔触位置
    func addVertices(vertice: SCNVector3) {
        
        let currenVertice = vertice
        
        self.lineVertices.append(currenVertice)
        let r:Double = MQARSCNController.sharedInstance.linewidth
        let verticeCount = self.lineVertices.count
        
        if verticeCount == 2 {
            
            let previousVertice = self.lineVertices[verticeCount-2]
            var tempPreviousVertices:[SCNVector3] = []//线条信息
            for index in 0...40 {//圆等分成40个点连接
                
                //算出围绕当前点半径r 圆上的所有点
                let t = Double(index) * (Double.pi * 2 / 40)
                let s = atan(-(Double(previousVertice.x)*cos(t) + Double(previousVertice.y)*sin(t)) / Double(previousVertice.z))
                let xt = Double(currenVertice.x) + r * cos(s) * cos(t)
                let yt = Double(currenVertice.y) + r * cos(s) * sin(t)
                let zt = Double(currenVertice.z) + r * sin(s)
                
                let ver = SCNVector3Make(Float(xt), Float(yt), Float(zt))
                tempPreviousVertices.append(ver)
            }
            self.roundPreviousVertices = tempPreviousVertices
        } else if verticeCount > 2  {
            
            let previousVertice = self.lineVertices[verticeCount-2]
            var roundLineVertices:[SCNVector3] = []
            var roundLineIndices:[UInt32] = []
            var tempPreviousVertices:[SCNVector3] = []
            for index in 0...40 {
                
                let t = Double(index) * (Double.pi * 2 / 40)
                
                let s = atan(-(Double(previousVertice.x)*cos(t) + Double(previousVertice.y)*sin(t)) / Double(previousVertice.z))
                let xt = Double(currenVertice.x) + r * cos(s) * cos(t)
                let yt = Double(currenVertice.y) + r * cos(s) * sin(t)
                let zt = Double(currenVertice.z) + r * sin(s)
                
                let ver = SCNVector3Make(Float(xt), Float(yt), Float(zt))
                tempPreviousVertices.append(ver)
                
                roundLineVertices.append(ver)
                roundLineVertices.append(roundPreviousVertices[index])
                
                let verticesCount = UInt32(roundLineVertices.count)
                roundLineIndices.append(verticesCount-2)
                roundLineIndices.append(verticesCount-1)
            }
            
            self.roundPreviousVertices = tempPreviousVertices
            

            
            let geometry = SCNGeometry(sources: [SCNGeometrySource(vertices: roundLineVertices)], elements: [SCNGeometryElement(indices: roundLineIndices, primitiveType: .triangleStrip)])
            
            let material = SCNMaterial()
            material.isDoubleSided = true
            material.diffuse.contents = MQARSCNController.sharedInstance.linecolour

            geometry.firstMaterial = material
            let node = SCNNode(geometry: geometry)
            self.addChildNode(node)
        }
    }
    
    func removeAllVertices() {
        
        self.lineVertices.removeAll()
        self.roundPreviousVertices.removeAll()
    }
}

