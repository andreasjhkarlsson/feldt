//
//  GameScene.swift
//  Feldt
//
//  Created by Andreas Karlsson on 2015-10-03.
//  Copyright (c) 2015 Andreas Karlsson. All rights reserved.
//

import SpriteKit
import Darwin

extension Array {
    func iter(functor: (Element) -> ()) {
        for element in self {
            functor(element)
        }
    }
}

class GameScene: SKScene {
    
    let grid = GridLayout()
    
    let edges = (0..<(COLUMNS+1)*ROWS).map { _ in Edge() }
    
    var pressPoint: CGPoint? = nil
    
    override func didMoveToView(view: SKView) {
        
        edges.iter {self.addChild($0)}
        
        grid.apply(edges)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            pressPoint = touch.locationInNode(self)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pressPoint = nil
    }
    
    override func update(currentTime: CFTimeInterval) {
        grid.apply(edges)
        
        if let point = pressPoint {
            RepulsionForce(position:point).apply(edges)
        }
    }
}
