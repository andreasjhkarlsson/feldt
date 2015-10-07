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
    
    func distance(p1: CGPoint, p2: CGPoint) -> CGFloat {
        let dx = p1.x - p2.x
        let dy = p1.y - p2.y
        return sqrt(dx*dx + dy*dy)
    }
    
}

class RubberBands: Transformation {
    
    
    override func apply(edges: Array<Edge>) {
        
        for edge in edges {
            
            let d = distance(edge.orig, p2: edge.position)

            let r = atan2(edge.orig.y-edge.position.y, edge.orig.x-edge.position.x)
            let m = 1.0 + (d / 15.0)
            
            edge.position.x += cos(r) * m
            edge.position.y += sin(r) * m
            
            if(d < 2.0 || m > d) {
                edge.position = edge.orig
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
            let d = sqrt(distance(position,p2: edge.position))
            let r = atan2(position.y-edge.position.y, position.x-edge.position.x)
            var m = (33.0 / (d / 2.5))
            m = min(m,30.0)
            if m < 0.0 { m = 0.0 }
            edge.position.x -= cos(r) * m
            edge.position.y -= sin(r) * m
           
        }
    }
    
}

class ColorDistance: Transformation {
    
    override func apply(edges: Array<Edge>) {
        
        for edge in edges {
            let d = distance(edge.position,p2: edge.orig)
            
            let z = (min(d/4.5,80) / 40.0)
            let r = CGFloat(1.0)
            let g = 1.0 - z
            let b = 1.0 - z
            let a = CGFloat(1.0)
            
            edge.color = UIColor(red: r, green: g, blue: b, alpha: a)
        }
        
    }
}
