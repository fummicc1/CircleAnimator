//
//  ViewController.swift
//  Sample04
//
//  Created by Fumiya Tanaka on 2018/12/29.
//  Copyright © 2018 Fumiya Tanaka. All rights reserved.
//

import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? TouchView {
            let scene = SKScene(size: CGSize(width: view.frame.size.width, height: -view.frame.size.height))
            scene.anchorPoint = CGPoint(x: 0, y: 1)
            scene.backgroundColor = .green
            view.presentScene(scene)
        }
        
    }
}

