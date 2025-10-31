//
//  OnboardingViewPresenter.swift
//  Library App
//
//  Created by Владимир Царь on 21.10.2025.
//

import Foundation
import UIKit

protocol OnboardingViewPresenterProtocol: AnyObject {
    var mokData: [OnboardingViewData] { get }
    func startApp()
}

class OnboardingViewPresenter: OnboardingViewPresenterProtocol {
    var mokData: [OnboardingViewData] = OnboardingViewData.mockData
    
    weak var view: OnboardingViewProtocol?
    
    init(view: any OnboardingViewProtocol) {
        self.view = view
    }
    
    func startApp() {
        UserDefaults.standard.set(WindowCase.main.rawValue, forKey: "state")
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.main])
    }
}
