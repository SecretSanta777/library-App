//
//  RegistView.swift
//  Library App
//
//  Created by Владимир Царь on 20.10.2025.
//

import UIKit
import SwiftUI

protocol RegistViewProtocol: BaseViewProtocol {
    
}
class RegistView: UIViewController, RegistViewProtocol {
    
    typealias PresenterType = RegistViewPresenterProtocol
    var presenter: PresenterType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = RegistViewContent { [weak self] name in
            guard let self = self else { return }
            self.presenter?.checkName(name: name)
        }
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
        
    }
    

}
