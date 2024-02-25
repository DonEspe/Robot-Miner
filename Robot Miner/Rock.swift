//
//  Rocks.swift
//  Robot Miner
//
//  Created by Don Espe on 2/24/24.
//

import Foundation

import SpriteKit

struct Rock {
    var position = CGPoint(x: 0, y: 0)
    var texture = SKTexture(image: .crystals1)

    var value = 10.0
    var remaining = 1.0
}
