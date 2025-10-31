//
//  SceneDelegate.swift
//  Library App
//
//  Created by Владимир Царь on 19.10.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(windowManager), name: .windowManager, object: nil)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = PreviewView()
        self.window?.makeKeyAndVisible()
    }
    
    @objc private func windowManager(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: WindowCase],
        let window = userInfo[.windowInfo] else { return }
        
        switch window {
        case .reg:
            self.window?.rootViewController = Builder.createRegistView()
        case .onboarding:
            self.window?.rootViewController = Builder.createUnboardingView()
        case .main:
            self.window?.rootViewController = Builder.createMainView()
        }
        
    }
    
    
    
}

enum WindowCase: String {
    case reg, onboarding, main
}
