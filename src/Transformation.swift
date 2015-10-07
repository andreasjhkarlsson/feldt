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

class RubberBands: Transformation {
    
    
    override func apply(edges: Array<Edge>) {
        
        for edge in edges {
            
            let gridPosition = edge.orig
            
            let dx = gridPosition.x - edge.position.x
            let dy = gridPosition.y - edge.position.y
            let d = sqrt(dx*dx + dy*dy)

            let r = atan2(gridPosition.y-edge.position.y, gridPosition.x-edge.position.x)
            let m = 1.0 + (d / 15.0)
            
            edge.position.x += cos(r) * m
            edge.position.y += sin(r) * m
            
            if(d < 2.0 || m > d) {
                edge.position = gridPosition
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
            var m = (33.0 / (d / 2.5))
            m = min(m,30.0)
            if m < 0.0 { m = 0.0 }
            edge.position.x -= cos(r) * m
            edge.position.y -= sin(r) * m
           
        }
    }
    
}