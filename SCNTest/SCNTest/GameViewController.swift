//
//  GameViewController.swift
//  SCNTest
//
//  Created by Bruno Omella Mainieri on 04/10/19.
//  Copyright © 2019 Bruno Omella Mainieri. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    var scene:GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        scene = GameScene(named: "art.scnassets/ramp.scn")!
        scene!.setupScene()
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        scnView.delegate = scene
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }
    
    var initialTouchPosition:CGPoint?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        initialTouchPosition = touches.first?.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currentTouchPosition = touches.first?.location(in: self.view), let initialTouchPosition = initialTouchPosition else { return }
        let vector:SCNVector3 = SCNVector3((currentTouchPosition.x - initialTouchPosition.x) * 0.005, (initialTouchPosition.y - currentTouchPosition.y) * 0.005, 0)
        scene?.playerNode?.physicsBody?.velocity = vector
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        initialTouchPosition = nil
    }

    
}
