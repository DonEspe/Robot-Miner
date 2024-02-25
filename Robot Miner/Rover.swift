//
//  Rover.swift
//  Robot Miner
//
//  Created by Don Espe on 2/24/24.
//

import Foundation
import SpriteKit

struct Rover {
    var sprite = SKSpriteNode()
    
    var position = CGPoint(x: 0, y: 0)
    var moveTo = CGPointZero
    var zRotation = 0.0
    var texture = SKTexture(image: .robot3Dblue)
    var speed = 5.0

    mutating func rotate(toFace node: SKNode) {
        let angle = atan2(node.position.y - position.y, node.position.x - position.x)
        zRotation = angle - (CGFloat.pi / 2)
    }

    mutating func rotate(toPoint: CGPoint) -> CGFloat {
        let angle = atan2(toPoint.y - sprite.position.y, toPoint.x - sprite.position.x)
        zRotation = angle //- (CGFloat.pi / 2)
        return zRotation
    }

    func distance(toPoint: CGPoint) -> CGFloat {
        let xdist = sprite.position.x - toPoint.x
        let ydist = sprite.position.y - toPoint.y

        return sqrt(xdist * xdist + ydist * ydist)
    }
}
