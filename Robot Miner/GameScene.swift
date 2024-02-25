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
    var rocks = [String: Rock]()

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

        for i in 0...10 {
            let crystal = SKSpriteNode(texture: .init(image: .crystals1))
            crystal.position.x = CGFloat.random(in: -150...150)
            crystal.position.y = CGFloat.random(in: -350...350)
            crystal.name = "rock" + String(i)

            rocks[crystal.name ?? ""] = (Rock(position: crystal.position, texture: crystal.texture ?? .init(image: .rockGreyLarge), value: Double.random(in: 1...40), remaining: 1.0))
            addChild(crystal)
        }

//        blueRover = SKSpriteNode(texture: .init(image: .robot3Dblue))
//        blueRover.position = CGPoint(x: 20, y: 20)
//        addChild(blueRover)
//
//        redRover = SKSpriteNode(texture: .init(image: .robot3Dred))
//        redRover.position = CGPoint(x: 75, y: 75)
//        redRover.color = .green
//        redRover.blendMode = .multiply
//        addChild(redRover)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        player.moveTo = pos
//        player.sprite.removeAllActions()
//        player.position = rover.position
//        let angle = player.rotate(toPoint: pos)
////        rover.zRotation = angle
//        let move = SKAction.sequence([
//            .move(to: pos, duration: 0.01 * player.distance(toPoint: pos))])
////        blueRover.position = pos
//        let angleChange = abs(player.sprite.zRotation - angle)
//        let rotate = SKAction.sequence([.rotate(toAngle: angle, duration: 0.1 * angleChange, shortestUnitArc: true)])
//        let seq = SKAction.sequence([rotate, move])
//        player.sprite.run(move)
//        player.sprite.run(rotate)
//        player.position = rover.position
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        player.moveTo = pos
        //        player.position = rover.position
//        let angle = player.rotate(toPoint: pos)
//        //        rover.zRotation = angle
//        let move = SKAction.sequence([
//            .move(to: pos, duration: 0.01 * player.distance(toPoint: pos))])
//        //        blueRover.position = pos
//        let angleChange = abs(player.sprite.zRotation - angle)
//        let rotate = SKAction.sequence([.rotate(toAngle: angle, duration: 0.1 * angleChange, shortestUnitArc: true)])
//        let seq = SKAction.sequence([rotate, move])
//        player.sprite.run(rotate)
//        player.sprite.run(move)
        //        player.position = rover.position

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
        print("player x", player.position.x, ", camera x: ", camera?.position.x, ", sceneSize: ", scene?.size)
        let yDist = player.position.y - (camera?.position.y)!
        if yDist > ((scene?.size.height )! / 2) - 200 {
            camera?.position.y += 2.0
        }
        if yDist < -((scene?.size.height)! / 2 - 200){
            camera?.position.y -= 2.0
        }
        let xDist = player.position.x - (camera?.position.x)!
        if xDist > ((scene?.size.width)! / 2) - 100 {
            camera?.position.x += 2.0
        }
        if xDist < -(((scene?.size.width)! / 2) - 100) {
            camera?.position.x -= 2.0
        }
    }

    override func update(_ currentTime: TimeInterval) {
        let newPlayerPosition = moveRover(rover: player)
        if player.moveTo.x != player.position.x || player.moveTo.y != player.position.y {
            player.sprite.zRotation = player.rotate(toPoint: newPlayerPosition)
        }
        player.position = moveRover(rover: player)
        player.sprite.position = player.position

        displayRocks(list: rocks)

        moveCamera()


        // Called before each frame is rendered
    }
}
