//
//  DetailsView.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import UIKit
import SwiftUI

protocol DetailsViewProtocol: BaseViewProtocol {
    
}

class DetailsView: UIViewController, DetailsViewProtocol {
    var presenter: PresenterType?
    
    typealias PresenterType = DetailsViewPresenterProtocol
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = DetailsViewContent(book: presenter?.book) { [weak self] in
            guard let self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
        print(UserDefaults.standard.object(forKey: "name"))
    }
}
