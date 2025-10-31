//
//  MainView.swift
//  Library App
//
//  Created by Владимир Царь on 23.10.2025.
//

import UIKit
import SwiftUI

protocol MainViewProtocol: BaseViewProtocol {
    
}

class MainViewModel: ObservableObject {
    @Published var readingBooks: [Book] = []
    @Published var unreadBooks: [Book] = []
    @Published var willReadBooks: [Book] = []
    
}

class MainView: UIViewController, MainViewProtocol {
    
    typealias PresenterType = MainViewPresenterProtocol
    var presenter: PresenterType?
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = MainViewContent(viewModel: viewModel) { book in
            self.navToVC(book: book)
        }
        let content = UIHostingController(rootView: contentView)
            
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        self.presenter?.fetch()
        viewModel.readingBooks = self.presenter?.readBooks ?? []
        viewModel.unreadBooks = self.presenter?.unreadBooks ?? []
        viewModel.willReadBooks = self.presenter?.willReadBooks ?? []
    }
    
    private func navToVC(book: Book?) {
        if let book {
            let detailsVC = Builder.createDetailsView(book: book)
            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            let vc = Builder.createAddView()
            navigationController?.pushViewController(vc, animated: true)
            print("tapped")
        }
    }
    
}

