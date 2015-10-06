//
//  Transformation.swift
//  Feldt
//
//  Created by Andreas Karlsson on 2015-10-06.
//  Copyright © 2015 Andreas Karlsson. All rights reserved.
//

import Foundation
import SpriteKit


class Transformation {
    func apply (edges: Array<Edge>) {
        preconditionFailure("This method must be overridden")
    }
}

class GridLayout: Transformation {
    override func apply(edges: Array<Edge>) {
        var x = 0
        var y = 0
        for edge in edges {
            
            edge.position = CGPoint(x: (WIDTH/Double(COLUMNS)) * Double(x), y:(HEIGHT/Double(ROWS))*Double(y))
            
            if x >= COLUMNS {
                x = 0
                y += 1
            } else {
                x += 1
            }
        }
    }
}

class RepulsionForce: Transformation {
    
    var position = CGPoint()
    
    init(position: CGPoint) {
        self.position = position
    }
    
    override func apply(edges: Array<Edge>) {
        
        for edge in edges {
            let dx = position.x - edge.position.x
            let dy = position.y - edge.position.y
            var d = sqrt(dx*dx + dy*dy)
            d = sqrt(d)
            let r = atan2(position.y-edge.position.y, position.x-edge.position.x)
            var m = 60.0 - d
            if m < 0.0 { m = 0.0 }
            edge.position.x -= cos(r) * m
            edge.position.y -= sin(r) * m
                
           
        }
    }
    
}