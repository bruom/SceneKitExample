//
//  GameScene.swift
//  SCNTest
//
//  Created by Bruno Omella Mainieri on 04/10/19.
//  Copyright © 2019 Bruno Omella Mainieri. All rights reserved.
//

import SceneKit

class GameScene:SCNScene, SCNPhysicsContactDelegate, SCNSceneRendererDelegate{
    
    static let playerMask = 1 << 0 // 000000000000001
    static let floorMask = 1 << 1 //  000000000000010
    static let pickupMask = 1 << 5 // 000000000100000
    
    var playerNode:SCNNode?
    var scoreNodes:Int = 0
    
    func setupScene(){
        physicsWorld.gravity = SCNVector3(0, 0, -5)
        physicsWorld.contactDelegate = self
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: -10, z: 12)
        cameraNode.look(at: SCNVector3(0, 0, 0))
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ball node
        playerNode = rootNode.childNode(withName: "sphere", recursively: true)!
        playerNode?.physicsBody?.categoryBitMask = GameScene.playerMask
        playerNode?.physicsBody?.contactTestBitMask = GameScene.pickupMask
        playerNode?.physicsBody?.collisionBitMask = GameScene.floorMask
        
        // configure physics
        for eachNode in rootNode.childNodes.filter({ (aNode) -> Bool in
            aNode.name == "floor"
        }){
            eachNode.physicsBody?.categoryBitMask = GameScene.floorMask
        }
    }
    
    public func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        var node1:SCNNode
        var node2:SCNNode
        
        if contact.nodeA.physicsBody!.categoryBitMask < contact.nodeB.physicsBody!.categoryBitMask {
            node1 = contact.nodeA
            node2 = contact.nodeB
        } else {
            node1 = contact.nodeB
            node2 = contact.nodeA
        }
        
        //Ball & Any Floor
        if (node1.physicsBody!.categoryBitMask & GameScene.playerMask != 0) && (node2.physicsBody!.categoryBitMask & GameScene.floorMask != 0){
        }
        
        //Ball & Pickup
        if (node1.physicsBody!.categoryBitMask & GameScene.playerMask != 0) && (node2.physicsBody!.categoryBitMask & GameScene.pickupMask != 0) {
            node2.removeFromParentNode()
            scoreNodes -= 1
        }
    }
    
    var lastTime:TimeInterval = 0
    var elapsedTime:TimeInterval = 0
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let delta = time - lastTime
        elapsedTime += delta
        
        if elapsedTime > 1.3 && scoreNodes < 10 {
            elapsedTime = 0
            let newNode = ScoreNode()
            let randX = CGFloat.random(in: -2.3...2.3)
            let randY = CGFloat.random(in: -2.3...2.3)
            newNode.position = SCNVector3(randX, randY, 0.05)
            rootNode.addChildNode(newNode)
            scoreNodes += 1
        }
        
        
        lastTime = time
    }
    
}
