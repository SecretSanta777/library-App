//
//  AddViewPresenter.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import Foundation

protocol AddViewPresenterProtocol {
    func searchBook(by title: String)
}

class AddViewPresenter: AddViewPresenterProtocol {
    weak var view: AddBookViewProtocol?
    private let manager = BookNetworkManager()
    init(view: AddBookViewProtocol) {
        self.view = view
    }
    
    func searchBook(by title: String) {
        manager.searchBookRequest(q: title) { [weak self] books in
            guard let self else { return }
            switch books {
            case .success(let success):
                DispatchQueue.main.async {
                    self.view?.goToListView(books: success)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
