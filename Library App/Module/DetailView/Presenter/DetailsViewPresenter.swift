//
//  DetailsViewPresenter.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import Foundation

protocol DetailsViewPresenterProtocol: AnyObject {
    var book: Book { get }
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    weak var view: DetailsViewProtocol?
    var book: Book
    
    init(view: DetailsViewProtocol?, book: Book) {
        self.view = view
        self.book = book
    }
}
