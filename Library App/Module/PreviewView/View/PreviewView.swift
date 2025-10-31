//
//  PreviewView.swift
//  Library App
//
//  Created by Владимир Царь on 20.10.2025.
//

import UIKit
import Lottie

class PreviewView: UIViewController {
    
    var state: WindowCase = .reg
    
    lazy var lottieView: LottieAnimationView = {
        $0.frame.size = CGSize(width: view.frame.width - 80, height: view.frame.height - 80)
        $0.center = view.center
        $0.loopMode = .playOnce
        return $0
    }(LottieAnimationView(name: "books"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgMain
        view.addSubview(lottieView)
        
        if let stateRaw = UserDefaults.standard.string(forKey: "state") {
            if let state = WindowCase(rawValue: stateRaw) {
                self.state = state
            }
        }
        
        lottieView.play(fromFrame: 0, toFrame: 120, loopMode: .playOnce) { completed in
            NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: self.state])
        }
    }
}
