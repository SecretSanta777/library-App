//
//  OnboardingView.swift
//  Library App
//
//  Created by Владимир Царь on 21.10.2025.
//

import UIKit
import SwiftUI

protocol OnboardingViewProtocol: BaseViewProtocol {
    
}

class OnboardingView: UIViewController, OnboardingViewProtocol {
    
    var presenter: PresenterType?
    typealias PresenterType = OnboardingViewPresenterProtocol
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = OnboardingViewContent(slides: presenter?.mokData ?? []) { [weak self] in
            print("Next")
            guard let self else { return }
            self.presenter?.startApp()
        }

        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
        
    }
    


}
