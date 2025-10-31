//
//  AddDetailsViewPresenter.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import Foundation

protocol AddDetailsViewPresenterProtocol: AnyObject {
    var book: BookModelItem { get }
    var viewModel: AddDetailsViewModel { get set }
    func createBookDescription()
    func createBook(image: ImageType, bookDescription: String, bookName: String, authorName: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class AddDetailsViewPresenter: AddDetailsViewPresenterProtocol {
    
    var book: BookModelItem
    private let manager = NetworkManager()
    
    weak var view: AddDetailsViewProtocol?
    var viewModel = AddDetailsViewModel()
    private let dbManager = DataBaseManager.shared
    init(view: AddDetailsViewProtocol?, book: BookModelItem) {
        self.view = view
        self.book = book
    }
    func createBookDescription() {
        manager.sendRequest(bookName: book.title ?? "" ) { description in
            DispatchQueue.main.async {
                self.viewModel.bookDescription = description
            }
        }
    }
    
    func createBook(image: ImageType, bookDescription: String, bookName: String, authorName: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        switch image {
        case .local(let uIImage):
            let imageData = uIImage.jpegData(compressionQuality: 1)!
            dbManager.createBook(name: bookName, author: authorName, description: bookDescription, cover: imageData)
            completion(.success(true))
        case .network(let urlString):
            if let urlString, let url = URL(string: "https://covers.openlibrary.org/b/id/\(urlString)-M.jpg") {
                manager.loadCover(url: url) { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .success(let imageData):
                        self.dbManager.createBook(name: bookName, author: authorName, description: bookDescription, cover: imageData)
                        completion(.success(true))
                    case .failure(let failure):
                        let _ = failure as? SaveError
                        DispatchQueue.main.async {
                            self.viewModel.isAddError = true
                        }
                    }
                }
            }
        }
    }
    
}
