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
    
    let rubber = RubberBands()
    
    let color = ColorDistance()
    
    var edges: [Edge] = []
    
    var pressPoints = Set<UITouch>()
    
    override func didMoveToView(view: SKView) {
        
        for y in 0.stride(to: Int(size.height), by: EDGE_DISTANCE) {
            for x in 0.stride(to: Int(size.width), by: EDGE_DISTANCE) {
                let edge = Edge(orig: CGPoint(x: x, y: y))
                edge.position = CGPoint(x: size.width / 2.0,y: size.height / 2.0)
                edges += [edge]
                self.addChild(edge)
            }
        }
        
        view.multipleTouchEnabled = true
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pressPoints = pressPoints.union(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pressPoints = pressPoints.subtract(touches)
    }
    
    override func update(currentTime: CFTimeInterval) {
        rubber.apply(edges)
        
        for touch in pressPoints {
            RepulsionForce(position:touch.locationInNode(self)).apply(edges)
        }
        
        color.apply(edges)
        
    }
}
