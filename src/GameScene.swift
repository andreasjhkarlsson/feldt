//
//  GameScene.swift
//  Feldt
//
//  Created by Andreas Karlsson on 2015-10-03.
//  Copyright (c) 2015 Andreas Karlsson. All rights reserved.
//

import SpriteKit
import Darwin

var edges: [Edge] = []

class GameScene: SKScene {
    
    let grid = GridLayout()
    
    override func didMoveToView(view: SKView) {
        
        for _ in 0..<((COLUMNS+1)*(ROWS+1)) {
            let edge = Edge()
            self.addChild(edge)
            edges += [edge]
        }
        
        grid.apply(edges)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        grid.apply(edges)
        for touch in touches {
            let location = touch.locationInNode(self)
            let transformation = RepulsionForce(position: location)
            transformation.apply(edges)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //for edge in edges { edge.resetPosition()}
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
