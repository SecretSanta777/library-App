//
//  RegistViewPresenter.swift
//  Library App
//
//  Created by Владимир Царь on 20.10.2025.
//

import Foundation

protocol RegistViewPresenterProtocol: AnyObject {
    func checkName(name: String)
}

class RegistViewPresenter: RegistViewPresenterProtocol {
    
    weak var view: (any RegistViewProtocol)?
    init (view: any RegistViewProtocol) {
        self.view = view
    }
    
    func checkName(name: String) {
        if name.count >= 2 {
            UserDefaults.standard.set(WindowCase.onboarding.rawValue, forKey: "state")
            UserDefaults.standard.set(name, forKey: "name")
            NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.onboarding])
        } else {
            print("error")
        }
    }
    
}
