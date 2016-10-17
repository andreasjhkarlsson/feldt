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
    func iter(_ functor: (Element) -> ()) {
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
    
    override func didMove(to view: SKView) {
        
        for y in stride(from: 0, to: Int(size.height), by: EDGE_DISTANCE) {
            for x in stride(from: 0, to: Int(size.width), by: EDGE_DISTANCE) {
                let edge = Edge(orig: CGPoint(x: x, y: y))
                edge.position = CGPoint(x: size.width / 2.0,y: size.height / 2.0)
                edges += [edge]
                self.addChild(edge)
            }
        }
        
        view.isMultipleTouchEnabled = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressPoints = pressPoints.union(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressPoints = pressPoints.subtracting(touches)
    }
    
    override func update(_ currentTime: TimeInterval) {
        rubber.apply(edges)
        
        for touch in pressPoints {
            RepulsionForce(position:touch.location(in: self)).apply(edges)
        }
        
        color.apply(edges)
        
    }
}
