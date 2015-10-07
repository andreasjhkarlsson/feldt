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
    
    var pressPoints = Set<UITouch>()
    
    override func didMoveToView(view: SKView) {
        
        view.multipleTouchEnabled = true
        
        edges.iter {self.addChild($0)}
        
        grid.apply(edges)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pressPoints = pressPoints.union(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pressPoints = pressPoints.subtract(touches)
    }
    
    override func update(currentTime: CFTimeInterval) {
        grid.apply(edges)
        
        for touch in pressPoints {
            RepulsionForce(position:touch.locationInNode(self)).apply(edges)
        }
    }
}
