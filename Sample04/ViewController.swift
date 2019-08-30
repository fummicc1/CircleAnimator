//
//  ViewController.swift
//  Sample04
//
//  Created by Fumiya Tanaka on 2018/12/29.
//  Copyright © 2018 Fumiya Tanaka. All rights reserved.
//

import SpriteKit

class ViewController: UIViewController {

    var scene: SKScene!
    
    var orientation: UIDeviceOrientation? {
        didSet {
            shouldUpdate = orientation == oldValue ? false : true
        }
    }
    
    var shouldUpdate: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? TouchView {
            scene = SKScene(size: CGSize(width: view.frame.size.width, height: -view.frame.size.height))
            scene.anchorPoint = CGPoint(x: 0, y: 1)
            view.presentScene(scene)
        }
        
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { (notification) in
            self.orientation = UIDevice.current.orientation
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let view = view as? TouchView, shouldUpdate else {
            return
        }        
        scene = SKScene(size: CGSize(width: view.frame.size.width, height: -view.frame.size.height))
        scene.anchorPoint = CGPoint(x: 0, y: 1)
        view.presentScene(scene)
        view.restart()
    }
}

