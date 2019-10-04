//
//  ScoreNode.swift
//  SCNTest
//
//  Created by Bruno Omella Mainieri on 04/10/19.
//  Copyright © 2019 Bruno Omella Mainieri. All rights reserved.
//

import SceneKit

class ScoreNode:SCNNode{
    
    static let geom = SCNPyramid(width: 1, height: 1, length: 1)
 
    override init(){
        super.init()
        self.geometry = ScoreNode.geom
        self.geometry?.materials.first?.diffuse.contents = UIColor.yellow
        self.scale = SCNVector3(0.2, 0.2, 0.2)
        self.eulerAngles = SCNVector3(CGFloat.pi/2, 0, 0)
        
        self.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        self.physicsBody?.categoryBitMask = GameScene.pickupMask
        
        let spinAction = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat.pi*2, duration: 2.0)
        let upAction = SCNAction.moveBy(x: 0, y: 0, z: 0.3, duration: 1.0)
        let downAction = SCNAction.moveBy(x: 0, y: 0, z: -0.3, duration: 1.0)
        let moveAction = SCNAction.sequence([upAction,downAction])
        let groupAction = SCNAction.group([spinAction,moveAction])
        self.runAction(SCNAction.repeatForever(groupAction))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
