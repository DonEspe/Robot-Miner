//
//  Rocks.swift
//  Robot Miner
//
//  Created by Don Espe on 2/24/24.
//

import Foundation

import SpriteKit

enum RockType:String, CaseIterable {
    case red
    case yellow
    case green
    case blue
    case purple
    case rubble
}

struct Rock {
    var position = CGPoint(x: 0, y: 0)
    var texture = SKTexture(image: .marsRockLarge)
    var type = RockType.rubble

    var value = 10
    var remaining = 6.0
    var name = ""

    func getTexture() -> SKTexture {
        var useTexture = SKTexture(image: .marsRockLarge)
        if remaining <= 4 && remaining > 2 {
            if type == .rubble {
                useTexture = SKTexture(image: .marsRockMedium)
            } else {
                useTexture = SKTexture(imageNamed: "marsRock" + type.rawValue.capitalized + "Sparkles")
            }
        }
        if remaining > 1 && remaining <= 2 && type != .rubble {
            useTexture = SKTexture(imageNamed: "crystals" + type.rawValue.capitalized)
        }
        if remaining > 1 && remaining <= 2 && type == .rubble {
            useTexture = SKTexture(image: .marsRockMedium)
        }
        if remaining <= 1 {
            useTexture = SKTexture(image: .marsRockSmall)

        }

        return useTexture
    }
}
