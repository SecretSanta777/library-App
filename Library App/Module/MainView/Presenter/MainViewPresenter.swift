//
//  MainView.swift
//  Library App
//
//  Created by Владимир Царь on 23.10.2025.
//

import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    var name: String { get }
    var books: [Book] { get set }
    var readBooks: [Book] { get }
    var unreadBooks: [Book] { get }
    var willReadBooks: [Book] { get }
    func fetch()
}

class MainViewPresenter: MainViewPresenterProtocol {
    var readBooks: [Book] = []
    var unreadBooks: [Book] = []
    var willReadBooks: [Book] = []
    
    var name: String
    var books: [Book] = []
    weak var view: MainViewProtocol?
    private var bookService = DataBaseManager.shared
    
    init(view: MainViewProtocol?) {
        self.view = view
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
        fetch()
    }
    
    func setBooks(newValue: [Book]) {
        readBooks = newValue.filter{ $0.status == BookStatus.read.rawValue}
        unreadBooks = newValue.filter{ $0.status == BookStatus.didRead.rawValue}
        willReadBooks = newValue.filter{ $0.status == BookStatus.willRead.rawValue}
    }
    
    func fetch() {
        bookService.fetchBooks()
        setBooks(newValue: bookService.books)
    }
    
}
