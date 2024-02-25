//
//  GameScene.swift
//  Robot Miner
//
//  Created by Don Espe on 2/24/24.
//

import SpriteKit


class GameScene: SKScene {

    var blueRover = SKSpriteNode()
    var redRover = SKSpriteNode()
    var player = Rover()
    var rover = SKSpriteNode()
    var scoreLabel = SKLabelNode(text: "Score: 0")
    var rocks = [String: Rock]()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        player.sprite.name = "player"

        let cameraNode = SKCameraNode()

        cameraNode.position = CGPoint(x: 0.0,
                                      y: 0.0)

        scene?.addChild(cameraNode)
        scene?.camera = cameraNode

        player.sprite = SKSpriteNode(texture: player.texture)
        player.sprite.position = player.position
        player.sprite.name = "player"
        addChild(player.sprite)

        scoreLabel.position = CGPoint(x: 0, y: 300)
        camera?.addChild(scoreLabel)

        for i in 0...30 {
            let crystal = SKSpriteNode(texture: .init(image: .crystals1))
            crystal.position.x = CGFloat.random(in: -500...500)
            crystal.position.y = CGFloat.random(in: -1000...1000)
            crystal.name = "rock" + String(i)

            rocks[crystal.name ?? ""] = (Rock(position: crystal.position, texture: crystal.texture ?? .init(image: .rockGreyLarge), value: Int.random(in: 1...40), remaining: 1.0, name: crystal.name ?? ""))
            addChild(crystal)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        player.moveTo = pos
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        player.moveTo = pos
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for t in touches { self.touchDown(atPoint: t.location(in: self))

        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    func moveRover(rover: Rover) -> CGPoint {
        var position = rover.position
        if rover.moveTo.x != rover.position.x || rover.moveTo.y != rover.position.y {
            let xDist = rover.moveTo.x - rover.position.x
            let yDist = rover.moveTo.y - rover.position.y
            var moveX = xDist
            var moveY = yDist

            if abs(moveX) > rover.speed {
                if moveX < 0 {
                    moveX = -rover.speed
                } else {
                    moveX = rover.speed
                }
            }

            if abs(moveY) > rover.speed {
                if moveY < 0 {
                    moveY = -rover.speed
                } else {
                    moveY = rover.speed
                }
            }

            position.x += moveX
            position.y += moveY
        }
        return position
    }

    func displayRocks(list: [String: Rock]) {
        for item in list {
            //do stuff
        }
    }

    func moveCamera() {
        guard camera != nil else { return }
        guard scene != nil else { return }

        let yDist = player.position.y - (camera!.position.y)
        if yDist > ((scene?.size.height )! / 2) - 200 {
            camera!.position.y += 2.0
        }
        if yDist < -((scene?.size.height)! / 2 - 200){
            camera!.position.y -= 2.0
        }
        let xDist = player.position.x - (camera!.position.x)
        if xDist > ((scene?.size.width)! / 2) - 150 {
            camera!.position.x += 2.0
        }
        if xDist < -(((scene?.size.width)! / 2) - 150) {
            camera!.position.x -= 2.0
        }
    }

    func checkForRocks(position: CGPoint, range: CGFloat) -> [Rock] {
        var foundRock = [Rock]()
        for rock in rocks {
            if abs(rock.value.position.x - position.x) < range && abs(rock.value.position.y - position.y) < range {
                foundRock.append(rock.value)
            }
        }
        return foundRock
    }

    override func update(_ currentTime: TimeInterval) {
        let newPlayerPosition = moveRover(rover: player)
        if player.moveTo.x != player.position.x || player.moveTo.y != player.position.y {
            player.sprite.zRotation = player.rotate(toPoint: newPlayerPosition)
        }
        player.position = moveRover(rover: player)
        player.sprite.position = player.position

        let foundRocks = checkForRocks(position: player.position, range: player.sprite.size.width / 2 + 15)

        if !foundRocks.isEmpty {
            player.moveTo = player.position
        }
        print("before:", rocks.count)

        for rock in foundRocks {
            for node in self.children {
                if node.name == rock.name {
                    node.removeFromParent()
                }
            }
            score += rock.value
            rocks[rock.name] = nil
        }
        print("after: ", rocks.count)

        displayRocks(list: rocks)

        moveCamera()
    }
}
