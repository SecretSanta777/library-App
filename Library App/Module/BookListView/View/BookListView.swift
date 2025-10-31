//
//  BookListView.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import UIKit
import SwiftUI

protocol BookListViewProtocol: BaseViewProtocol {
    
}

class BookListView: UIViewController, BookListViewProtocol {
    typealias PresenterType = BookListPresenterProtocol
    var presenter: PresenterType?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = BookListViewContent(books: presenter?.bookList ?? []) { [weak self] book in
            guard let self else { return }
            let detailVC = Builder.createAddDetailsView(book: book)
            self.navigationController?.pushViewController(detailVC, animated: true)
        } goBack: {
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
