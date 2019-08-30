//
//  Sample.swift
//  Sample04
//
//  Created by Fumiya Tanaka on 2018/12/29.
//  Copyright © 2018 Fumiya Tanaka. All rights reserved.
//

import SpriteKit

class TouchView: SKView {
    
    var currentNode: TouchNode?
    
    var nodeArray: [TouchNode] = []
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first!
        let location = touch.location(in: self)
        let node = TouchNode(circleOfRadius: 30)
        node.position = location
        node.currentLocation = location
        node.fillColor = .red
        currentNode = node
        if let scene = self.scene {
            scene.addChild(currentNode!)
            nodeArray.append(currentNode!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesMoved(touches, with: event)
        
        if let node = currentNode {
            let touch = touches.first!
            let preLocation = node.currentLocation ?? touch.location(in: self)
            node.currentLocation = touch.location(in: self)
            let dx = -preLocation.x + node.currentLocation!.x
            let dy = -preLocation.y + node.currentLocation!.y
            let animation = SKAction.move(by: CGVector(dx: dx, dy: dy), duration: 0.1)
            //            node.position = node.position + CGPoint(x: dx, y: dy)
            node.run(animation)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if let node = currentNode {
            let smallAnimation = SKAction.scale(to: 2.0, duration: 0.3)
            let bigAnimation = SKAction.scale(to: 0.5, duration: 0.3)
            let changeColor = SKAction.run({
                let color = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255, green: CGFloat(Int.random(in: 0...255)) / 255, blue: CGFloat(Int.random(in: 0...255)) / 255, alpha: 1)
                node.fillColor = color
            })
            
            let action = SKAction.sequence([smallAnimation, bigAnimation, changeColor])
            node.run(SKAction.repeatForever(action))
        }
        
        if nodeArray.count >= 10 {
            for (_, node) in self.nodeArray.enumerated() {
                
                let centerAnimation = SKAction.move(to: self.center, duration: 3.0)
                
                node.run(centerAnimation)
            }
        }
    }
    
    func restart() {
        scene?.removeAllChildren()
        for (_, node) in self.nodeArray.enumerated() {
            node.position = node.currentLocation ?? .zero
            scene?.addChild(node)
        }
    }
}

class TouchNode: SKShapeNode {
    
    var currentLocation: CGPoint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touchesBegan")
    }
}
