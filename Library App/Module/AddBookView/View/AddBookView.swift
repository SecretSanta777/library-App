//
//  AddBookView.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import UIKit
import SwiftUI

protocol AddBookViewProtocol: BaseViewProtocol {
    func goToListView(books: [BookModelItem])
}

class AddBookView: UIViewController, AddBookViewProtocol {
    
    typealias PresenterType = AddViewPresenterProtocol
    var presenter: PresenterType?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = AddBookViewContent { [weak self] direction in
            guard let self else { return }
            switch direction {
            case .back:
                self.navigationController?.popViewController(animated: true)
            case .forward(let book):
                if book.count > 2 {
                    self.presenter?.searchBook(by: book)
                }
            }
        }
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
        print(UserDefaults.standard.object(forKey: "name"))
    }
    
    func goToListView(books: [BookModelItem]) {
        let vc = Builder.createBookListView(books: books)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
