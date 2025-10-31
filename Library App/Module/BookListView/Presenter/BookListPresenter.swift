//
//  BookListPresenter.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import Foundation

protocol BookListPresenterProtocol: AnyObject {
    var bookList: [BookModelItem]? { get }
}

class BookListPresenter: BookListPresenterProtocol {
    var bookList: [BookModelItem]?
    
    weak var view: BookListViewProtocol?
    init(view: BookListViewProtocol?, bookList: [BookModelItem]?) {
        self.view = view
        self.bookList = bookList
    }
}
