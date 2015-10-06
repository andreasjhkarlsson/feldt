//
//  Edge.swift
//  Feldt
//
//  Created by Andreas Karlsson on 2015-10-06.
//  Copyright © 2015 Andreas Karlsson. All rights reserved.
//

import Foundation
import SpriteKit


class Edge: SKSpriteNode {
    
    init() {
        super.init(texture: nil,color: EDGE_COLOR, size: CGSize(width: EDGE_SIZE, height: EDGE_SIZE))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}